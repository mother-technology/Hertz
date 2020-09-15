import Combine
import Foundation
import HealthKit

class WorkoutManager: NSObject, ObservableObject {
    static let shared = WorkoutManager()

    let healthStore = HKHealthStore()
    var session: HKWorkoutSession!
    var builder: HKLiveWorkoutBuilder!

    let builderDelegate = WorkoutManagerBuilderDelegate()

    @Published var heartrate: Double = 0

    func requestAuthorization() {
        let typesToShare: Set = [
            HKQuantityType.workoutType(),
        ]

        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
        ]

        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { _, _ in
        }
    }

    func workoutConfiguration() -> HKWorkoutConfiguration {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .other
        configuration.locationType = .indoor

        return configuration
    }

    func startWorkout() {
        do {
            session = try HKWorkoutSession(
                healthStore: healthStore,
                configuration: workoutConfiguration()
            )
            builder = session.associatedWorkoutBuilder()
        } catch {
            return
        }

        builderDelegate.action = { statistics in
            self.updateForStatistics(statistics)
        }
        builder.delegate = builderDelegate

        session.delegate = self

        builder.dataSource = HKLiveWorkoutDataSource(
            healthStore: healthStore,
            workoutConfiguration: workoutConfiguration()
        )

        session.startActivity(with: Date())
        builder.beginCollection(withStart: Date()) { _, _ in
        }
    }

    func endWorkout() {
        if session.state == .running {
            session.end()
        }
    }

    func updateForStatistics(_ statistics: HKStatistics?) {
        guard let statistics = statistics else {
            return
        }

        DispatchQueue.main.async {
            switch statistics.quantityType {
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                let value = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit)
                let roundedValue = Double(round(1 * value!) / 1)
                self.heartrate = roundedValue
                
                let userInfo: [String: Any] = [
                    "beat": roundedValue
                ]

                NotificationCenter.default.post(
                    name: Notification.Name.Hertz.beat,
                    object: self,
                    userInfo: userInfo
                )

            default:
                return
            }
        }
    }
}

class WorkoutManagerBuilderDelegate: NSObject, HKLiveWorkoutBuilderDelegate {
    var action: ((_ statistics: HKStatistics?) -> Void)?

    func workoutBuilderDidCollectEvent(_: HKLiveWorkoutBuilder) {}

    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else {
                return // Nothing to do.
            }

            let statistics = workoutBuilder.statistics(for: quantityType)
            action?(statistics)
        }
    }
}

extension WorkoutManager: HKWorkoutSessionDelegate {
    func workoutSession(_: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState,
                        from _: HKWorkoutSessionState, date _: Date) {
        if toState == .ended {
            builder.endCollection(withEnd: Date()) { _, _ in
                self.builder.finishWorkout { _, _ in
                    // Optionally display a workout summary to the user.
                }
            }
        }
    }

    func workoutSession(_: HKWorkoutSession, didFailWithError _: Error) {}
}
