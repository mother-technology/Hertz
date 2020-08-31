import Foundation
import SwiftUI

struct Tick: Hashable {
    let angle: Angle
    let color: Color
    let opacity: Double
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

class HertzViewModel: ObservableObject {
    @Published var currentAngle = Angle.degrees(0)
    @Published var ticks: [Tick] = []

    let maxCycles = 2

    let breatheInColor = Color(red: 0.495, green: 0.523, blue: 0.645)
    let breatheOutColor = Color(red: 0.495, green: 0.281, blue: 0.283)
    let breatheHoldColor = Color(red: 1, green: 1, blue: 1)

    let cycleSegments: [CycleSegment] = [
        .breatheHold(1),
        .breatheIn(3),
        .breatheHold(1),
        .breatheOut(3),
    ]

    private var totalTicks: Int = 0
    private var degressPerTick: Double = 0

    private var currentTick: Int = 0
    private var previousTick: Int = 0
    private var seconds: Double = 0

    private var timer: Timer?
    private var currentSegment: CycleSegment?

    var factor: Double = 1

    init() {
        ticks = makeTicks()
        degressPerTick = 360.0 / Double(totalTicks)
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { t in
            let seconds = self.seconds + (t.timeInterval * self.factor)
            self.seconds = min(seconds, Double(self.totalTicks))

            if self.seconds == Double(self.totalTicks) {
                self.seconds = 0
            }

            // Calculate angle
            let angle = 360.0 / Double(self.totalTicks) * self.seconds
            self.currentAngle = Angle.degrees(angle)

            self.previousTick = self.currentTick
            if angle < self.degressPerTick {
                self.currentTick = 0
            } else {
                let tick = Int(floor(self.currentAngle.degrees / self.degressPerTick))
                if tick != self.currentTick {
                    let tick = self.ticks[tick]
                    let segment = tick.segment

                    switch segment {
                    case .breatheIn:
                        self.factor = 1
                    case .breatheOut:
                        self.factor = 0.75
                    case .breatheHold:
                        self.factor = 1
                    }
                }
            }
        }
    }

    private func getColor(for cycleSegment: CycleSegment) -> Color {
        switch cycleSegment {
        case .breatheIn:
            return breatheInColor
        case .breatheOut:
            return breatheOutColor
        case .breatheHold:
            return breatheHoldColor
        }
    }

    private func getCircularIndex(for index: Int) -> Int {
        if index < 0 {
            let i = abs(index) % ticks.count
            if i == 0 {
                return i
            }

            return ticks.count - i
        } else if index >= ticks.count {
            return index % ticks.count
        } else {
            return index
        }
    }

    private func makeTicks() -> [Tick] {
        let secondsForCycle = cycleSegments.reduce(0) { (result, cycleSegment) -> Double in
            result + cycleSegment.getSeconds()
        }

        totalTicks = Int(Double(maxCycles) * secondsForCycle)

        var ticks: [Tick] = []

        var count = 0
        for _ in 1 ... Int(maxCycles) {
            for cycleSegment in cycleSegments {
                for _ in 1 ... Int(cycleSegment.getSeconds()) {
                    let angle = Angle.degrees(Double(count) / Double(totalTicks) * 360)
                    let tick = Tick(angle: angle, color: getColor(for: cycleSegment), opacity: 1, segment: cycleSegment)
                    ticks.append(tick)

                    count = count + 1
                }
            }
        }

        return ticks
    }
}

struct HertzViewModel_Previews: PreviewProvider {
    static var previews: some View {
        Text("le monde est à vous!")
    }
}
