import Combine
import Foundation
import HealthKit

//// DEBUG
//let workoutPredicate = HKQuery.predicateForWorkouts(with: .mindAndBody)
//let sampleType = HKObjectType.workoutType()
//let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
//let limit = 0
//
//let query = HKSampleQuery(
//    sampleType: sampleType,
//    predicate: workoutPredicate,
//    limit: limit,
//    sortDescriptors: [sortDescriptor]) { (query, results, error) in
//        // TODO: - Error handling, Mikael
//        var workouts: [HKWorkout] = []
//        if let results = results {
//            for result in results {
//                if let workout = result as? HKWorkout, workout.sourceRevision.source.name == "Hertz" {
//                    workouts.append(workout)
//                }
//            }
//        }
//
//        guard let latest = workouts.first else {
//            return
//        }
//
//        guard let distanceType =
//                HKObjectType.quantityType(forIdentifier: .heartRate) else {
//            fatalError("*** Unable to create a distance type ***")
//        }
//        let workoutPredicate = HKQuery.predicateForObjects(from: latest)
//        let startDateSort = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
//
//        let query = HKSampleQuery(sampleType: distanceType,
//                                  predicate: workoutPredicate,
//                                  limit: 0,
//                                  sortDescriptors: [startDateSort]) { (sampleQuery, results, error) -> Void in
//            print(error)
//            guard let distanceSamples = results as? [HKQuantitySample] else {
//                // Perform proper error handling here.
//                return
//            }
//
//            print(distanceSamples)
//            // Use the workout's distance samples here.
//        }
//
//        healthStore?.execute(query)
//}
//
//healthStore?.execute(query)

final class WorkoutManager: NSObject, ObservableObject {
    static let shared = WorkoutManager()
    
    // Metadata
    let HeartrateMetadataBaseLine = "baseline"
    
    private var healthStore: HKHealthStore?
    private var session: HKWorkoutSession?
    private var builder: HKLiveWorkoutBuilder?
    
    private let builderDelegate = WorkoutManagerBuilderDelegate()
    
    let publisher: AnyPublisher<Double, Never>
    let subject = PassthroughSubject<Double, Never>()
    
    private var heartRateSamples: [HKQuantitySample] = []
    private var startDate: Date?
    
    override init() {
        publisher = subject.eraseToAnyPublisher()
        
        if !HKHealthStore.isHealthDataAvailable() {
            return
        }
        
        healthStore = HKHealthStore()
    }
    
    func requestAuthorization() {
        if !HKHealthStore.isHealthDataAvailable() {
            return
        }
        
        let typesToShare: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.workoutType()
        ]
        
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.workoutType()
        ]
        
        healthStore?.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
            // TODO: - Error handling, Mikael

        }
    }
    
    private func workoutConfiguration() -> HKWorkoutConfiguration {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .mindAndBody
        configuration.locationType = .unknown
        
        return configuration
    }
    
    func startWorkout() {
        if !HKHealthStore.isHealthDataAvailable() {
            return
        }
        
        guard let healthStore = healthStore else {
            // TODO: - Error handling, Mikael
            return
        }
        
        heartRateSamples.removeAll()
        
        do {
            session = try HKWorkoutSession(
                healthStore: healthStore,
                configuration: workoutConfiguration()
            )
            builder = session?.associatedWorkoutBuilder()
        } catch {
            // TODO: - Error handling, Mikael
            return
        }
        
        builderDelegate.action = { statistics in
            self.updateForStatistics(statistics)
        }
        builder?.delegate = builderDelegate
        session?.delegate = self
        builder?.dataSource = HKLiveWorkoutDataSource(
            healthStore: healthStore,
            workoutConfiguration: workoutConfiguration()
        )
        
        startDate = Date()
        session?.startActivity(with: startDate!)
        builder?.beginCollection(withStart: startDate!) { success, error in
            // TODO: - Error handling, Mikael
        }
    }
    
    func addInterval(for heartRate: Double, with metaData:[String: Any]) {
        if !HKHealthStore.isHealthDataAvailable() {
            return
        }
        
        guard let heartRateQuantityType = HKSampleType.quantityType(forIdentifier: .heartRate) else {
            // TODO: - Error handling, Mikael
            return
        }

        let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
        let now = Date()
        
        let sample = HKQuantitySample(type: heartRateQuantityType, quantity: .init(unit: heartRateUnit, doubleValue: heartRate), start: now, end: now, metadata: metaData)
        
        heartRateSamples.append(sample)
    }
    
    func endWorkout() {
        if !HKHealthStore.isHealthDataAvailable() {
            return
        }
        
        if session?.state == .running {
            session?.end()
            
            builder?.add(heartRateSamples, completion: { [self] (success, error) in
                // TODO: - Error handling, Mikael
                builder?.endCollection(withEnd: Date()) { [self] success, error in
                    // TODO: - Error handling, Mikael
                    builder?.finishWorkout { [self] workout, error in
                        // TODO: - Error handling, Mikael
                    }
                }
            })
        }
    }
    
    private func updateForStatistics(_ statistics: HKStatistics?) {
        guard let heartRateQuantityType = HKSampleType.quantityType(forIdentifier: .heartRate) else {
            // TODO: - Error handling, Mikael
            return
        }
        
        switch statistics?.quantityType {
        case heartRateQuantityType:
            let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
            guard let value = statistics?.mostRecentQuantity()?.doubleValue(for: heartRateUnit) else { return }
            let roundedValue = Double(round(1 * value) / 1)

            self.subject.send(roundedValue)
        default:
            return
        }
    }
}

private class WorkoutManagerBuilderDelegate: NSObject, HKLiveWorkoutBuilderDelegate {
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
                        from _: HKWorkoutSessionState, date _: Date) {}
    
    func workoutSession(_: HKWorkoutSession, didFailWithError _: Error) {}
}
