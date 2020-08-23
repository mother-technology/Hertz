import SwiftUI

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
