import Combine
import Foundation
import SwiftUI

struct Tick: Hashable {
    let angle: Angle
    let segment: CycleSegment
}

enum CycleSegment: Hashable {
    case breatheIn(Double)
    case breatheOut(Double)
    case breatheHold(Double)

    func getSeconds() -> Double {
        switch self {
        case let .breatheIn(seconds):
            return seconds
        case let .breatheOut(seconds):
            return seconds
        case let .breatheHold(seconds):
            return seconds
        }
    }
}

struct HertzModel {
    private(set) var absoluteStartTime: TimeInterval? = nil
    var currentTime: TimeInterval = 0
    var elapsedTime: TimeInterval = 0
    
    var maxCycles: Int = 2
    var totalTicks: Int = 0
    var degressPerTick: Double = 0
    var factor: Double = 1
    var ticks: [Tick] = []

    // TODO(MIKAEL): Need to think about this
    private var initialHeartRate: Double = 0
    private var initialFactor: Double = 1

    var cycleSegments: [CycleSegment] =
        [
            .breatheHold(1),
            .breatheIn(3),
            .breatheHold(1),
            .breatheOut(3),
        ]

    var currentAngle: Angle {
        guard let start = absoluteStartTime else { return Angle.degrees(0) }

        let s = elapsedTime.truncatingRemainder(dividingBy: Double(totalTicks))

        return Angle.degrees(degressPerTick * s)
    }

    mutating func update(elapsedTime withTimeInterval: TimeInterval) {
        self.elapsedTime += (withTimeInterval * factor)
    }
    
    mutating func update(heartRate withHeartRate: Double) {
        if initialHeartRate == 0 {
            initialHeartRate = withHeartRate
            print(withHeartRate)
            return
        }

        if initialHeartRate <= withHeartRate {
            let diff = withHeartRate - initialHeartRate
            factor = self.initialFactor + (diff / 10)
        } else {
            let diff = initialHeartRate - withHeartRate
            factor = max(initialFactor - (diff / 10), 0.1)
        }
        
        print("\(initialHeartRate), \(withHeartRate), \(factor)")
    }

    mutating func start(at time: TimeInterval) {
        absoluteStartTime = time
        elapsedTime = 0
    }

    mutating func stop() {
        absoluteStartTime = nil
        initialHeartRate = 0
    }

    mutating func generateTicks() {
        let secondsForCycle = cycleSegments.reduce(0) { (result, cycleSegment) -> Double in
            result + cycleSegment.getSeconds()
        }

        totalTicks = Int(Double(maxCycles) * secondsForCycle)
        degressPerTick = 360.0 / Double(totalTicks)

        var count = 0
        for _ in 1 ... Int(maxCycles) {
            for cycleSegment in cycleSegments {
                for _ in 1 ... Int(cycleSegment.getSeconds()) {
                    let angle = Angle.degrees(Double(count) / Double(totalTicks) * 360)
                    let tick = Tick(angle: angle, segment: cycleSegment)
                    ticks.append(tick)
                    count = count + 1
                }
            }
        }
    }
}

class ContentViewModel: ObservableObject {
    @Published private var hertzModel: HertzModel

    var breatheInColor = Color(red: 0.495, green: 0.523, blue: 0.645)
    var breatheOutColor = Color(red: 0.495, green: 0.281, blue: 0.283)
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

    func stop() {
        timer?.invalidate()
        timer = nil
        hertzModel.stop()
    }

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [unowned self] timer in
            self.hertzModel.update(elapsedTime: timer.timeInterval)
//            self.hertzModel.currentTime = Date().timeIntervalSinceReferenceDate
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
