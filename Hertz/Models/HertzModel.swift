import Foundation
import Combine
import SwiftUI

func circularArray<Element>(array: [Element], index: Int) -> Element {
    if index < 0 {
        let i = abs(index) % array.count
        if i == 0 {
            return array[i]
        }

        return array[array.count - i]
    } else if index >= array.count {
        return array[index % array.count]
    } else {
        return array[index]
    }
}

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

public struct HertzModel {
    private(set) var absoluteStartTime: TimeInterval? = nil
    var elapsedTime: TimeInterval = 0

    var maxCycles: Int = 2
    var totalTicks: Int = 0
    var degressPerTick: Double = 0
    var factor: Double = 1
    var targetFactor: Double = 1
    var factorIncrement: Double = 0
    var ticks: [Tick] = []

    private var initialHeartRate: Double = 0
    private var initialFactor: Double = 1

    var heartRate: Double = 0

    var insideSpeedUpAngle: Bool = false
    var cycleSegments: [CycleSegment] =
        [
            .breatheHold(1),
            .breatheIn(3),
            .breatheHold(1),
            .breatheOut(4),
        ]

    var currentAngle: Angle {
        if elapsedTime == 0 {
            return Angle.degrees(0)
        }

        let s = elapsedTime.truncatingRemainder(dividingBy: Double(totalTicks))

        return Angle.degrees(degressPerTick * s)
    }

    mutating func update(elapsedTime withTimeInterval: TimeInterval) {
        if insideSpeedUpAngle {
            if factor < targetFactor {
                let newFactor = factor + factorIncrement
                factor = min(newFactor, targetFactor)
            } else if factor > targetFactor {
                let newFactor = factor - factorIncrement
                factor = max(newFactor, targetFactor)
            }
            elapsedTime += (withTimeInterval * factor)
        } else {
            elapsedTime += withTimeInterval
        }

        let currentTickIndex = Int(floor(elapsedTime.truncatingRemainder(dividingBy: Double(totalTicks))))
        let currentTick = ticks[currentTickIndex]
        
        if case .breatheHold = currentTick.segment {
            let nextTick = circularArray(array: ticks, index: currentTickIndex + 1)
            if case .breatheOut = nextTick.segment {
                insideSpeedUpAngle = true
            } else {
                insideSpeedUpAngle = false
            }
        } else if case .breatheOut = currentTick.segment {
            insideSpeedUpAngle = true
        }
        
        if !insideSpeedUpAngle {
            targetFactor = 1
        }
    }

    mutating func update(heartRate withHeartRate: Double) {
        heartRate = withHeartRate

        if initialHeartRate == 0 {
            initialHeartRate = withHeartRate
            return
        }

        if initialHeartRate <= withHeartRate {
            let diff = withHeartRate - initialHeartRate
            targetFactor = initialFactor + (diff / 10.0)
            factorIncrement = diff / 10.0 / 10.0
        } else {
            let diff = initialHeartRate - withHeartRate
            targetFactor = max(initialFactor - (diff / 10.0), 0.1)
            factorIncrement = diff / 10.0 / 10.0
        }
    }

    mutating func start(at time: TimeInterval) {
        absoluteStartTime = time
        elapsedTime = 0
        initialHeartRate = 0
    }

    mutating func stop() {
        absoluteStartTime = nil
        elapsedTime = 0
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

