import UIKit

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }

    init(center: CGPoint, radius: CGFloat) {
        self = CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        )
    }
}
