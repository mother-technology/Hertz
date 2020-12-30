import SwiftUI

struct Dot: Shape {
    var circleRadius: CGFloat = 5

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY - circleRadius))
        path.addEllipse(in: CGRect(center: CGPoint(x: rect.midX, y: 0), radius: circleRadius))

        return path
    }
}
