import Combine
import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published private var hertzModel: HertzModel
    @Published var digitalScrollAmount: Double = 0
        
    var breatheInColor = Color(red: 0.2, green: 0.8, blue: 0.8) // (red: 0.495, green: 0.523, blue: 0.645)
    var breatheOutColor = Color(red: 0.501, green: 0, blue: 0)
    var breatheHoldColor = Color(red: 1, green: 1, blue: 1)

    private var timer: Timer?

    var cancellables = Set<AnyCancellable>()

    let workOutManager: WorkoutManager = .shared
    
    init(hertzModel: HertzModel) {
        self.hertzModel = hertzModel
        self.hertzModel.generateTicks()

        NotificationCenter.default
            .publisher(for: Notification.Name.Hertz.stop)
            .sink { [unowned self] _ in
                stop()
            }
            .store(in: &cancellables)

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
    }

    deinit {
        cancellables.forEach { c in
            c.cancel()
        }
    }
    
    var isRunning: Bool {
        hertzModel.absoluteStartTime != nil
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
    
/*    var scrollAmount: Double {
        hertzModel.scrollAmount
    }
*/
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
            return breatheInColor
        case .breatheOut:
            return breatheOutColor
        case .breatheHold:
            return breatheHoldColor
        }
    }
}

struct ContentViewModel_Previews: PreviewProvider {
    static var previews: some View {
        Text("le monde est à nous!")
    }
}
