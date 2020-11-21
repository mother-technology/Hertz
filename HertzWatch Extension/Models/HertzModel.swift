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
    let isFirst: Bool
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
    var crownFactor: Double = 1.0
    var targetFactor: Double = 1
    var factorIncrement: Double = 0
    var ticks: [Tick] = []

    private var avgHeartRate: Double = 0.0
    private var initialHeartRates:[Double] = []
    private var baselineHeartRateCount = 3
     
    private var initialFactor: Double = 1

    var heartRate: Double = 0
    
    private var digitalCrown: Double = 0
    
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
        let localTargetFactor = insideSpeedUpAngle ? targetFactor : 1
        if factor < localTargetFactor {
            let newFactor = factor + factorIncrement
            factor = min(newFactor, localTargetFactor)
        } else if factor > localTargetFactor {
            let newFactor = factor - factorIncrement
            factor = max(newFactor, localTargetFactor)
        }
        
        elapsedTime += (withTimeInterval * (factor + digitalCrown)) //while testing with digital crown
            
        let currentTickIndex = Int(floor(elapsedTime.truncatingRemainder(dividingBy: Double(totalTicks))))
        let currentTick = ticks[currentTickIndex]
        
        
        if case .breatheHold = currentTick.segment {
//            let nextTick = circularArray(array: ticks, index: currentTickIndex + 1)
//            if case .breatheOut = nextTick.segment, !nextTick.isFirst {
//                insideSpeedUpAngle = true
//            } else {
                insideSpeedUpAngle = false
//            }
        } else if case .breatheOut = currentTick.segment, !currentTick.isFirst {
            insideSpeedUpAngle = true
        }
 
    }

    mutating func update(digitalCrown withValue: Double) {
        digitalCrown = withValue
    }
    
    mutating func update(heartRate withHeartRate: Double) {
        
        heartRate = withHeartRate
        
        initialHeartRates.append(heartRate)
        
        if initialHeartRates.count <= baselineHeartRateCount {
            return
        }
        
        initialHeartRates.removeFirst()
        
        avgHeartRate = initialHeartRates.reduce(0.0, +) / Double(baselineHeartRateCount)
        
        if avgHeartRate <= withHeartRate {
            let diff = withHeartRate - avgHeartRate
            //targetFactor = min(initialFactor + (diff / 10.0), 1.6)
            targetFactor = initialFactor + (diff / 10.0)
            factorIncrement = diff / 10.0 / 10.0
        } else {
            let diff = avgHeartRate - withHeartRate
            targetFactor = max(initialFactor - (diff / 10.0), 0.6)
            factorIncrement = diff / 10.0 / 10.0
        }
    }

    mutating func start(at time: TimeInterval) {
        absoluteStartTime = time
        elapsedTime = 0
        avgHeartRate = 0
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
                for index in 1 ... Int(cycleSegment.getSeconds()) {
                    let angle = Angle.degrees(Double(count) / Double(totalTicks) * 360)
                    let tick = Tick(angle: angle, segment: cycleSegment, isFirst: index == 1)
                    ticks.append(tick)
                    count = count + 1
                }
            }
        }
    }
}

