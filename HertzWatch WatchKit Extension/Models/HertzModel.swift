import Combine
import Foundation
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

    func toString() -> String {
        switch self {
        case .breatheIn:
            return "breatheIn"
        case .breatheOut:
            return "breatheOut"
        case .breatheHold:
            return "breatheHold"
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
    var isInsideBreatheOut: Bool = false
    var ticks: [Tick] = []
    var averageHeartRateInOrHold: Double = 0.0
    var isFinished: Bool = false
    // var trainingTime: Double = 0

    private var heartRatesInOrHold: [Double] = []
    private var heartRatesOut: [Double] = []
    private var minHeartRateOut: Double = 0.0
    private var rollingAverageHeartRateNumber: Int = 3
    var allDifferences: [Double] = []
    var averageOfAllDifferences: Double = 0
    var maxOfAllDifferences: Double = 0
    var successImageIndex: Int = 1

    private var initialFactor: Double = 1
    private var initialFactorAfterSpeedChange: Double = 1

    var heartRate: Double = 0

    private var digitalCrownForSpeed: Double = 0
    private var digitalCrownForRevolutions: Double = 0

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

    let workOutManager: WorkoutManager = .shared

    private var previousTickSegment: String?

    mutating func update(elapsedTime withTimeInterval: TimeInterval) {
        if !isFinished {
            var currentTickIndex = Int(floor(elapsedTime.truncatingRemainder(dividingBy: Double(totalTicks))))
            currentTickIndex = currentTickIndex < 0 ? 0 : currentTickIndex
            let currentTick = ticks[currentTickIndex]

            let currentTickSegment = currentTick.segment.toString()
            if previousTickSegment != currentTickSegment && heartRate > 0 {
                workOutManager.addInterval(for: heartRate, with: currentTickSegment)
                previousTickSegment = currentTickSegment
            }

            let currentHalfRevolution = ceil(2 * elapsedTime / Double(totalTicks))

            if currentHalfRevolution > digitalCrownForRevolutions * 2 {
                workOutManager.endWorkout()
                isFinished = true
                stop()
            }

            if case .breatheOut = currentTick.segment {
                if !isInsideBreatheOut {
                    isInsideBreatheOut = true
                    insideSpeedDownAngle = true
                    targetFactor = initialFactorAfterSpeedChange - min(currentHalfRevolution / 55, 0.3) - (diffAvgMinHeartRate / 7)
                    // print("targetFactor: \(targetFactor), currentHalfRevolution: \(currentHalfRevolution), diffAvgMinHeartRate: \(diffAvgMinHeartRate), digitalCrownForSpeed: \(digitalCrownForSpeed), initialFactorAfterSpeedChange: \(initialFactorAfterSpeedChange)")
                    targetFactor = max(targetFactor, 0.5)
                    targetFactor = min(targetFactor, 1.5)
                    factor = initialFactorAfterSpeedChange
                    factorIncrement = (initialFactorAfterSpeedChange - targetFactor) * withTimeInterval / (currentTick.segment.getSeconds() / 2)
                }
            } else {
                targetFactor = initialFactorAfterSpeedChange
                isInsideBreatheOut = false
            }

            if insideSpeedDownAngle {
                if factor > targetFactor {
                    let newFactor = factor - factorIncrement
                    factor = max(newFactor, targetFactor)
                } else {
                    insideSpeedDownAngle = false
                    insideSpeedUpAngle = true
                    factor = targetFactor
                }
            } else if insideSpeedUpAngle {
                if factor < initialFactorAfterSpeedChange {
                    let newFactor = factor + factorIncrement
                    factor = min(newFactor, initialFactorAfterSpeedChange)
                } else {
                    insideSpeedUpAngle = false
                    targetFactor = initialFactorAfterSpeedChange
                }
            } else {
                factor = targetFactor
            }

            elapsedTime += withTimeInterval * factor
        }
    }

    mutating func update(digitalCrownForSpeed withValue: Double) {
        digitalCrownForSpeed = withValue
    }

    mutating func update(digitalCrownForRevolutions withValue: Double) {
        digitalCrownForRevolutions = withValue
    }

    mutating func update(heartRate withHeartRate: Double) {
        heartRate = withHeartRate

        let currentTickIndex = Int(floor(elapsedTime.truncatingRemainder(dividingBy: Double(totalTicks))))
        let currentTick = ticks[currentTickIndex]

        if case .breatheHold = currentTick.segment {
            heartRatesInOrHold.append(heartRate)
            if heartRatesOut.count > 0 {
                minHeartRateOut = heartRatesOut.min()!
                heartRatesOut.removeAll()
            }
        } else if case .breatheIn = currentTick.segment {
            heartRatesInOrHold.append(heartRate)
            if heartRatesOut.count > 0 {
                minHeartRateOut = heartRatesOut.min()!
                heartRatesOut.removeAll()
            }
        } else if case .breatheOut = currentTick.segment {
            heartRatesOut.append(heartRate)
        }

        if heartRatesInOrHold.count <= rollingAverageHeartRateNumber || minHeartRateOut == 0.0 {
            return
        }

        heartRatesInOrHold.removeFirst()

        averageHeartRateInOrHold = heartRatesInOrHold.reduce(0.0, +) / Double(rollingAverageHeartRateNumber)

        if averageHeartRateInOrHold > minHeartRateOut {
            diffAvgMinHeartRate = averageHeartRateInOrHold - minHeartRateOut
            allDifferences.append(diffAvgMinHeartRate)
        }
    }

    mutating func start(at time: TimeInterval) {
        absoluteStartTime = time
        elapsedTime = 0
        initialFactorAfterSpeedChange = initialFactor + (digitalCrownForSpeed - 3) / 35
        // TODO: Remove below?
        heartRatesInOrHold.removeAll()
        heartRatesOut.removeAll()
        minHeartRateOut = 0.0
        diffAvgMinHeartRate = 0.0
        // End TODO
    }

    mutating func returnToStart() {
        isFinished = false
    }

    mutating func stop() {
//        if let absoluteStartTime = absoluteStartTime {
//            trainingTime = Date().timeIntervalSinceReferenceDate - absoluteStartTime
//        }
//        else {
//            trainingTime = 0
//        }

        absoluteStartTime = nil
        elapsedTime = 0
        maxOfAllDifferences = 3 * (allDifferences.max() ?? 0) // adding factor to make the result less low
    }

    mutating func generateTicks() {
        let secondsForCycle = cycleSegments.reduce(0) { result, cycleSegment -> Double in
            result + cycleSegment.getSeconds()
        }

        totalTicks = Int(Double(maxCycles) * secondsForCycle) // move to start func?
        degressPerTick = 360.0 / Double(totalTicks) // move to start func?

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
