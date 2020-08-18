import SwiftUI

struct TickFace: View {
    
    let breatheIn = Color.init(red: 0.086, green: 0.855, blue: 0.890, opacity: 0.4)
    let breatheOut = Color.init(red: 0.086, green: 0.855, blue: 0.890, opacity: 0.4)
    let breatheHold = Color.init(red: 0.086, green: 0.855, blue: 0.890, opacity: 0)
    
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
        let degressPerSecond = 360.0 / normalizedRevolution
        
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
                ZStack {
                    Arc(
                        startAngle: .degrees(item.startDegree),
                        endAngle: .degrees(item.endDegree),
                        clockwise: true
                    ).fill(item.color)
                    Dott(circleRadius: 6)
                        .fill(Color.white)
                        .rotationEffect(.degrees(item.startDegree))
                }
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                self.makeSegmentsForCircle(self.segments)
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.width
                    )
                Circle()
                    .fill(
                        Color.init(
                            red: 0.1529411765,
                            green: 0.1725490196,
                            blue: 0.2039215686))
                    .frame(
                        width: geometry.size.width - 18,
                        height: geometry.size.width - 18
                    )
            }
        }
    }
}

struct Tick_Previews: PreviewProvider {
    static var previews: some View {
        TickFace()
        .padding()
        .background(
            Color.init(
                red: 0.08547224849,
                green: 0.1101305559,
                blue: 0.1441726089)
            .edgesIgnoringSafeArea(.all))
    }
}
