import SwiftUI

struct Dott: Shape {
    var circleRadius: CGFloat = 5
    var radiusOffset: CGFloat = 0
    func path(in rect: CGRect) -> Path {
        let centerPoint = CGPoint(x: rect.midX, y: rect.midY)

        var path = Path()
        path.move(to: centerPoint)
        path.addEllipse(in: CGRect(center: CGPoint(x: rect.midX, y: 0), radius: self.circleRadius))
        
        return path
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var radiusOffset: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        let centerPoint = CGPoint(x: rect.midX, y: rect.midY)
        
        var path = Path()
        path.move(to: centerPoint)
        path.addArc(
            center: centerPoint,
            radius: (rect.width / 2) + radiusOffset,
            startAngle: modifiedStart,
            endAngle: modifiedEnd,
            clockwise: !clockwise
        )
        path.move(to: centerPoint)
        
        return path
    }
}

// #colorLiteral(red: 0.1529411765, green: 0.1725490196, blue: 0.2039215686, alpha: 1)

// #colorLiteral(red: 0.1027758792, green: 0.7373578548, blue: 0.6097053885, alpha: 1)

// #colorLiteral(red: 0.9423447251, green: 0.353353709, blue: 0.3229573965, alpha: 1)

// #colorLiteral(red: 1, green: 0.9269918799, blue: 0.2507405877, alpha: 1)

// #colorLiteral(red: 0.1809364855, green: 0.2369545102, blue: 0.2317210436, alpha: 1)
struct Arc_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle()
                .fill(Color.init(red: 0.1529411765, green: 0.1725490196, blue: 0.2039215686))
            ZStack {
                Arc(
                    startAngle: .degrees(300),
                    endAngle: .degrees(90),
                    clockwise: true,
                    radiusOffset: -30
                )
                .fill(Color.init(red: 0.1027758792, green: 0.7373578548, blue: 0.6097053885))
//                .overlay(
//                    Circle()
//                        .stroke(
//                            Color.init(red: 0.1809364855, green: 0.2369545102, blue: 0.2317210436),
//                            lineWidth: 0.5
//                ))

                Arc(
                    startAngle: .degrees(90),
                    endAngle: .degrees(160),
                    clockwise: true
                )
                .fill(Color.init(red: 0.9423447251, green: 0.353353709, blue: 0.3229573965))

                Arc(
                    startAngle: .degrees(160),
                    endAngle: .degrees(300),
                    clockwise: true,
                    radiusOffset: -15
                )
                .fill(Color.init(red: 1, green: 0.9269918799, blue: 0.2507405877))

                ZStack {
                    Circle()
                        .fill(Color.white)
//                    .overlay(
//                        Circle()
//                            .stroke(
//                                Color.init(red: 0.1809364855, green: 0.2369545102, blue: 0.2317210436),
//                                lineWidth: 0.5
//                    ))
                    .frame(width: 200, height: 200)
                }
            }.frame(width: 300, height: 300)
        }.frame(width: 400, height: 400)
    }
}
