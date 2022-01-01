import Combine
import Foundation
import SwiftUI

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
    var degreesPerTick: Double = 0
    var factor: Double = 1
    var ticks: [Tick] = []
    var isFinished: Bool = false
    var beforeHeartRate: Int = 0
    var afterHeartRate: Int = 0
    var heartRate: Double = 0
    var diffAvgMinHeartRate: Double = 0.0
    
    private var initialFactor: Double = 1
    private var isInsideBreatheOut: Bool = false
    private var heartRatesInOrHold: [Double] = []
    private var heartRatesOut: [Double] = []
    private var allHeartRates: [Double] = []
    private var averageHeartRateInOrHold: Double = 0.0
    private var minHeartRateOut: Double = 0.0
    private var rollingAverageHeartRateNumber: Int = 3
    private var digitalCrownForSpeed: Double = 0
    private var digitalCrownForRevolutions: Double = 0
    private var parabelConstant:Double = 0
    private var xStartOfBreathOut:Double = 0
    private var lowestInitialFactor:Double = 0.25

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
        return Angle.degrees(degreesPerTick * s)
    }
    
    func avgOfArrayElementsFromStartToEnd(arr: [Double], start:Int, end: Int) -> Double {
        var sum: Double = 0.0
        let count: Double = Double(1 + end - start)
        
        for n in start...end {
            sum = arr[n] + sum
        }
        
        return sum/count
    }
    
    // Calculated by using the general calculation of y = ax^2 + bx + c, and three known dots on the parabel
    // Assuming that x=0 degrees gives top of the factor value, while x=40 degrees gives minimum value, and x=80 degrees (last red tick) gives same as 0 degrees
    func calculateParabelConstant(y2:Double) -> Double {
        
        let x2:Double = degreesPerTick * 4/2 // Change 4 to cycleSegment(.breatheOut)?
        let x3:Double = degreesPerTick * 4;
        // A polynom can be rewritten from y=ax^2 + bx + c into its factor form, y = k(x - x1)(x - x3) where x1 and x3 have y = 0. In our case, this means that y = k(x - 0)(x - x3) => y = kx^2 - x3*kx
        // We can then put in x2 (ex 40 degrees) and y2 (min point on parabel)
        
        let k:Double = y2 / (x2*x2-x2*x3)
        
        return k
    }
    
    func calculateFactor(x:Double, y1:Double = 0) -> Double {
        let x3:Double = degreesPerTick * 4; // Change 4 to cycleSegment(.breatheOut)?
        // Once more using y = kx^2 - x3*kx, given k (x^2 - x3*x) where x is the degree moved since start in breatheout segment
        let y:Double = parabelConstant * ( x * x - x3 * x)
        return y;
    }
    
    func calculateSpeedFactor() -> Double {
        let speedFactor:Double = (digitalCrownForSpeed - 3) / 10
        return speedFactor;
    }
    
    func calculateHeartRateFactor() -> Double {
        let heartRateFactor:Double = diffAvgMinHeartRate / 10
        return heartRateFactor;
    }
    

    let workOutManager: WorkoutManager = .shared

    private var previousTickSegment: String?

    mutating func update(elapsedTime withTimeInterval: TimeInterval) {
        
        // Skip if the clock is finished
        if isFinished {
            return
        }
        
        var currentTickIndex = Int(floor(elapsedTime.truncatingRemainder(dividingBy: Double(totalTicks))))
        currentTickIndex = currentTickIndex < 0 ? 0 : currentTickIndex
        let currentTick = ticks[currentTickIndex]

        let currentTickSegment = currentTick.segment.toString()
        if previousTickSegment != currentTickSegment && heartRate > 0 {
            workOutManager.addInterval(for: heartRate, with: currentTickSegment)
            previousTickSegment = currentTickSegment
        }

        // Have we reached the number of revolutions set in the start? If so, finish workout and return to start mode
        let currentHalfRevolution = ceil(2 * elapsedTime / Double(totalTicks))

        if currentHalfRevolution > digitalCrownForRevolutions * 2 {
            workOutManager.endWorkout()
            isFinished = true
            stop()
        }
        // End revolution

        if case .breatheOut = currentTick.segment {
            if !isInsideBreatheOut { // in order to only do this once when breathe out segment starts
                isInsideBreatheOut = true
                let y2 = -lowestInitialFactor - calculateHeartRateFactor() // lowest speed point is -0.5 minus (at the most) 0.2 for heartRate
                parabelConstant = calculateParabelConstant(y2: y2)
                xStartOfBreathOut = currentAngle.degrees
            }
            
            let newFactor = calculateFactor(x: currentAngle.degrees - xStartOfBreathOut)
            factor = max(initialFactor + newFactor, 0.005)
            
//            print("\(factor) \(currentAngle.degrees - xStartOfBreathOut)")
            
        } else {
            isInsideBreatheOut = false
            factor = initialFactor
        }

        elapsedTime += withTimeInterval * factor
        
    }

    mutating func update(digitalCrownForSpeed withValue: Double) {
        digitalCrownForSpeed = withValue
    }

    mutating func update(digitalCrownForRevolutions withValue: Double) {
        digitalCrownForRevolutions = withValue
    }

    mutating func update(heartRate withHeartRate: Double) {
        heartRate = withHeartRate
        allHeartRates.append(heartRate)
        
        let currentTickIndex = Int(floor(elapsedTime.truncatingRemainder(dividingBy: Double(totalTicks))))
        let currentTick = ticks[currentTickIndex]

        if case .breatheOut = currentTick.segment {
            heartRatesOut.append(heartRate)
            minHeartRateOut = heartRatesOut.min()!
        } else {
            heartRatesInOrHold.append(heartRate)
            heartRatesOut.removeAll()
        }

        // Too few heart rates recorded or no minHeartRateOut given, do nothing
        if heartRatesInOrHold.count <= rollingAverageHeartRateNumber || minHeartRateOut == 0.0 {
            return
        }

        // heartRatesInOrHold will always keep only the last rollingAverageHeartRateNumber (ex 3) values
        heartRatesInOrHold.removeFirst()

        averageHeartRateInOrHold = heartRatesInOrHold.reduce(0.0, +) / Double(rollingAverageHeartRateNumber)

        if averageHeartRateInOrHold > minHeartRateOut {
            diffAvgMinHeartRate = averageHeartRateInOrHold - minHeartRateOut
        }
        
    }

    mutating func start(at time: TimeInterval) {
        
        absoluteStartTime = time
        initialFactor = initialFactor + calculateSpeedFactor() // initialFactorAfterSpeedChange = initialFactor + (digitalCrownForSpeed - 3) / 35
        elapsedTime = 0
        
        // Cleanup in case we have been training already
        heartRatesInOrHold.removeAll()
        heartRatesOut.removeAll()
        minHeartRateOut = 0.0
        diffAvgMinHeartRate = 0.0
        allHeartRates = []
        beforeHeartRate = 0
        afterHeartRate = 0
    }

    mutating func returnToStart() {
        isFinished = false
    }

    mutating func stop() {
        absoluteStartTime = nil
        elapsedTime = 0
        
        //Calculate before and after heart rate for result screen
        if (allHeartRates.count >= 10) {
            beforeHeartRate = Int(round(avgOfArrayElementsFromStartToEnd(arr:allHeartRates, start:0, end:5)))
            afterHeartRate = Int(round(avgOfArrayElementsFromStartToEnd(arr:allHeartRates, start:allHeartRates.count - 6, end:allHeartRates.count - 1)))
        }
    }

    mutating func generateTicks() {
        
        let secondsForCycle = cycleSegments.reduce(0) { result, cycleSegment -> Double in
            result + cycleSegment.getSeconds()
        }

        totalTicks = Int(Double(maxCycles) * secondsForCycle)
        degreesPerTick = 360.0 / Double(totalTicks)

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
