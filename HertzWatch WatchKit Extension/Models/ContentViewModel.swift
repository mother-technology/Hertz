import Combine
import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published private var hertzModel: HertzModel
    @Published var digitalScrollAmount: Double = 0
    @Published var digitalScrollAmountForRevolutions: Double = 10.0

    private var timer: Timer?

    var cancellables = Set<AnyCancellable>()

    let workOutManager: WorkoutManager = .shared
    
    init(hertzModel: HertzModel) {
        self.hertzModel = hertzModel
        self.hertzModel.generateTicks()

        workOutManager
            .publisher
            .receive(on: RunLoop.main)
            .sink { [unowned self] value in
                self.hertzModel.update(heartRate: value)
            }
            .store(in: &cancellables)

        $digitalScrollAmount
            .receive(on: RunLoop.main)
            .sink { [unowned self] value in
                self.hertzModel.update(digitalCrown: value)
            }
            .store(in: &cancellables)
        $digitalScrollAmountForRevolutions
            .receive(on: RunLoop.main)
            .sink { [unowned self] value in
                self.hertzModel.update(digitalCrownForRevolutions: value)
            }
            .store(in: &cancellables)
    }

    deinit {
        cancellables.forEach { c in
            c.cancel()
        }
    }
    
    var isRunning: Bool {
        hertzModel.absoluteStartTime != nil
    }
    
    var isFinished: Bool {
        hertzModel.isFinished == true
    }

    var currentAngle: Angle {
        hertzModel.currentAngle
    }

    var ticks: [Tick] {
        hertzModel.ticks
    }

    var heartRate: Double {
        hertzModel.heartRate
    }

    var factor: Double {
        hertzModel.factor
    }
    
    var diffAvgMinHeartRate: Double {
        hertzModel.diffAvgMinHeartRate
    }
    
    var averageHeartRateInOrHold: Double {
        hertzModel.averageHeartRateInOrHold
    }
    
    var crownFactor: Double {
        hertzModel.crownFactor
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        hertzModel.stop()
        workOutManager.endWorkout()
    }

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [unowned self] timer in
            hertzModel.update(elapsedTime: timer.timeInterval)
        }

        hertzModel.start(at: Date().timeIntervalSinceReferenceDate)
        workOutManager.startWorkout()
    }

    func getColor(for cycleSegment: CycleSegment) -> Color {
        switch cycleSegment {
        case .breatheIn:
            return Color.BreathIn
        case .breatheOut:
            return Color.BreathOut
        case .breatheHold:
            return Color.BreathHold
        }
    }
}

struct ContentViewModel_Previews: PreviewProvider {
    static var previews: some View {
        Text("le monde est à nous!")
    }
}
