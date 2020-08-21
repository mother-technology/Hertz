import Foundation
import SwiftUI

struct Tick: Hashable {
    let angle: Angle
    let color: Color
    let opacity: Double
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

class HertzModel: ObservableObject {
    @Published var currentAngle: Angle = Angle.degrees(10)
    @Published var ticks: [Tick] = []
    
    let maxCycles = 3
    
    let breatheInColor = Color.init(red: 0.3555664718, green: 0.4603664279, blue: 0.579121232)
    let breatheOutColor = Color.init(red: 0.7711976171, green: 0.8416673541, blue: 0.8185895681)
    let breatheHoldColor = Color.init(red: 0.9599910378, green: 0.8189997077, blue: 0.7644532323)
    
    let cycleSegments: [CycleSegment] = [
        .breatheHold(2),
        .breatheIn(4),
        .breatheHold(2),
        .breatheOut(4),
    ]
    
    private var totalTicks: Int = 0
    private var ticksPerSecondScale: Double = 1.0
    private var seconds: Double = 0
    private var degressPerTick: Double = 0
    
    private var currentTick: Int = 0
    private var previousTick: Int = 0
    
    init() {
        ticks = makeTicks()
//        calculateTransparency()

        degressPerTick = 360.0 / Double(totalTicks)
        
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            let seconds = self.seconds + (timer.timeInterval / self.ticksPerSecondScale)
            self.seconds = min(seconds, Double(self.totalTicks))

            if self.seconds == Double(self.totalTicks) {
                self.seconds = 0
            }

            // Calculate angle
            let angle = 360.0 / Double(self.totalTicks) * self.seconds
            self.currentAngle = Angle.degrees(angle)
            
//            self.previousTick = self.currentTick
//            if angle < self.degressPerTick {
//                self.currentTick = 0
//            } else {
//                let tick = Int(floor(self.currentAngle.degrees / self.degressPerTick))
//                if tick != self.currentTick {
//                    self.currentTick = tick
//                }
//            }
//            self.calculateTransparency()
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
    
    private func calculateTransparency() {
        let currentTick = ticks[self.currentTick]
        ticks[self.currentTick] = Tick(angle: currentTick.angle, color: currentTick.color, opacity: 1)
        
        let previousTick = ticks[self.previousTick]
        ticks[self.previousTick] = Tick(angle: previousTick.angle, color: previousTick.color, opacity: 0.0)
    }
    
    private func makeTicks() -> [Tick] {
        let secondsForCycle = cycleSegments.reduce(0) { (result, cycleSegment) -> Double in
            result + cycleSegment.getSeconds()
        }
        
        totalTicks = Int(Double(maxCycles) * secondsForCycle)
        ticksPerSecondScale = 60.0 / Double(totalTicks)
        
        var ticks: [Tick] = []
        
        var count = 0
        for _ in 1...Int(maxCycles) {
            for cycleSegment in cycleSegments {
                for _ in 1...Int(cycleSegment.getSeconds()) {
                    let angle = Angle.degrees(Double(count) / Double(totalTicks) * 360)
                    let tick = Tick(angle: angle, color: getColor(for: cycleSegment), opacity: 1)
                    ticks.append(tick)
                    
                    count = count + 1
                }
            }
        }
        
        return ticks
    }
}
