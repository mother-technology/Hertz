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

struct SegmentFace: View {
    let breatheIn = Color.init(red: 0.3555664718, green: 0.4603664279, blue: 0.579121232)
    let breatheOut = Color.init(red: 0.7711976171, green: 0.8416673541, blue: 0.8185895681)
    let breatheHold = Color.init(red: 0.9599910378, green: 0.8189997077, blue: 0.7644532323)
    
    let segments: [Segment] = [
        .breatheIn(3),
        .breatheHold(2),
        .breatheOut(3),
        .breatheHold(2)
    ]
    
    func getColor(for segment: Segment) -> Color {
        switch segment {
        case .breatheIn:
            return breatheIn
        case .breatheOut:
            return breatheOut
        case .breatheHold:
            return breatheHold
        }
    }
    
    func makeSegmentsForCircle(_ cycleSegments: [Segment]) -> some View {
        let maxCyclesPerRevolution = 4
        
        let secondsForCycle = cycleSegments.reduce(0) { (result, segment) -> Double in
            result + segment.getSeconds()
        }
        
        let normalizedRevolution = Double(maxCyclesPerRevolution) * secondsForCycle
        let degressPerSecond = 360.0 / Double(normalizedRevolution)

        var currentDegree: Double = 0
        
        var d: [ArcSegment] = []
        
        for _ in 1...maxCyclesPerRevolution {
            for segment in cycleSegments {
                let endDegree = currentDegree + (Double(segment.getSeconds()) * degressPerSecond)
                let arcSegment = ArcSegment(startDegree: currentDegree, endDegree: endDegree, color: getColor(for: segment))
                d.append(arcSegment)
                currentDegree = endDegree
            }
        }
        
        return ZStack {
            ForEach(d, id: \.self) { item in
                Arc(
                    startAngle: .degrees(item.startDegree),
                    endAngle: .degrees(item.endDegree),
                    clockwise: true
                ).fill(item.color)
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                self.makeSegmentsForCircle(self.segments)
                Circle()
                    .fill(
                        Color.init(
                            red: 0.1529411765,
                            green: 0.1725490196,
                            blue: 0.2039215686))
                    .frame(
                        width: geometry.size.width - 130,
                        height: geometry.size.height - 130
                )
            }
        }
    }
}

struct HertzFace_Previews: PreviewProvider {
    static var previews: some View {
        SegmentFace()
    }
}
