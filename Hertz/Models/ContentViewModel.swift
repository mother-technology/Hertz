import Combine
import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published private var hertzModel: HertzModel
    
    var breatheInColor = Color(red: 0.2, green: 0.8, blue: 0.8) // (red: 0.495, green: 0.523, blue: 0.645)
    var breatheOutColor = Color(red: 0.501, green: 0, blue: 0)
    var breatheHoldColor = Color(red: 1, green: 1, blue: 1)

    private var timer: Timer?

    var cancellables = Set<AnyCancellable>()

    init(hertzModel: HertzModel) {
        self.hertzModel = hertzModel
        self.hertzModel.generateTicks()

        NotificationCenter.default
            .publisher(for: Notification.Name.Hertz.stop)
            .sink { [unowned self] _ in
                self.stop()
            }
            .store(in: &cancellables)

        NotificationCenter.default
            .publisher(for: Notification.Name.Hertz.beat)
            .receive(on: RunLoop.main)
            .sink { [unowned self] notification in
                guard
                    let uInfo = notification.userInfo,
                    let hr = uInfo["beat"] as? Double
                else {
                    return
                }

                self.hertzModel.update(heartRate: hr)
            }
            .store(in: &cancellables)
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

    func stop() {
        timer?.invalidate()
        timer = nil
        hertzModel.stop()
    }

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [unowned self] timer in
            self.hertzModel.update(elapsedTime: timer.timeInterval)
        }

        hertzModel.start(at: Date().timeIntervalSinceReferenceDate)
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
        Text("le monde est à vous!")
    }
}
