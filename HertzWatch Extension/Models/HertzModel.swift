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
    var factorIncrement: Double = 0.001
    var diffAvgMinHeartRate: Double = 0.0
    var ticks: [Tick] = []
    
    private var averageHeartRateInOrHold: Double = 0.0
    private var heartRatesInOrHold:[Double] = []
    private var heartRatesOut:[Double] = []
    private var minHeartRateOut: Double = 0.0
    private var rollingAverageHeartRateNumber: Int = 3
    
    private var initialFactor: Double = 1
    
    var heartRate: Double = 0
    
    private var digitalCrown: Double = 0
    
    var insideSpeedUpAngle: Bool = false
    var insideSpeedDownAngle: Bool = false
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
        
        let currentTickIndex = Int(floor(elapsedTime.truncatingRemainder(dividingBy: Double(totalTicks))))
        let currentTick = ticks[currentTickIndex]
        let nextTick = circularArray(array: ticks, index: currentTickIndex + 1)
        
        let currentHalfRevolution = ceil(2 * elapsedTime / Double(totalTicks))
        
        if case .breatheOut = currentTick.segment {
            targetFactor = 1 - ( currentHalfRevolution / 40 ) - ( diffAvgMinHeartRate / 7)
        } else {
            targetFactor = 1
        }
            
        if case .breatheHold = currentTick.segment {
            if case .breatheIn = nextTick.segment {
                insideSpeedUpAngle = true
            }
        } else if case .breatheOut = currentTick.segment {
            if case .breatheOut = nextTick.segment {
                insideSpeedDownAngle = true
            }
        }
            
        if insideSpeedUpAngle {
            if factor < targetFactor {
                let newFactor = factor + factorIncrement
                factor = min(newFactor, targetFactor)
            } else {
                insideSpeedUpAngle = false
                factor = targetFactor
            }
        } else if insideSpeedDownAngle {
            if factor > targetFactor {
                let newFactor = factor - factorIncrement
                factor = max(newFactor, targetFactor)
            } else {
                insideSpeedDownAngle = false
                factor = targetFactor
            }
        }
        
        elapsedTime += (withTimeInterval * (factor + ( digitalCrown / 7) ))
        print("elapsedTime: ", elapsedTime)
        print("factor: ", factor )
        print("currentSegment: ", currentTick.segment)
        
    }
    
    mutating func update(digitalCrown withValue: Double) {
        digitalCrown = withValue
    }
    
    mutating func update(heartRate withHeartRate: Double) {
        heartRate = withHeartRate
        
        let currentTickIndex = Int(floor(elapsedTime.truncatingRemainder(dividingBy: Double(totalTicks)))) //move to a place where it can be used by both update functions!
        let currentTick = ticks[currentTickIndex] //same here
        
        if case .breatheHold = currentTick.segment {
            heartRatesInOrHold.append(heartRate)
            if heartRatesOut.count > 0 {
                minHeartRateOut = heartRatesOut.min()!
                heartRatesOut.removeAll()
            }
        }
        else if case .breatheIn = currentTick.segment { //don't know how to do an OR so duplicated right now but should be merged with above
            heartRatesInOrHold.append(heartRate)
            if heartRatesOut.count > 0 {
                minHeartRateOut = heartRatesOut.min()!
                heartRatesOut.removeAll()
            }
        }
        else if case .breatheOut = currentTick.segment {
            heartRatesOut.append(heartRate)
        }
        
        if heartRatesInOrHold.count <= rollingAverageHeartRateNumber || minHeartRateOut == 0.0 {
            return
        }
        
        heartRatesInOrHold.removeFirst()
        
        averageHeartRateInOrHold = heartRatesInOrHold.reduce(0.0, +) / Double(rollingAverageHeartRateNumber)
        
        if averageHeartRateInOrHold > minHeartRateOut {
            diffAvgMinHeartRate = averageHeartRateInOrHold - minHeartRateOut
        }
    }
    
    mutating func start(at time: TimeInterval) {
        absoluteStartTime = time
        elapsedTime = 0
        heartRatesInOrHold.removeAll()
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

