import Foundation
import SwiftUI

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

