import Foundation
import SwiftUI

enum Segment: Hashable {
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

struct ArcSegment: Hashable {
    let startDegree: Double
    let endDegree: Double
    let color: Color
    
    var middleDegree: Double {
        get {
            return (endDegree - startDegree) + startDegree
        }
    }
}

