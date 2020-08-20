import SwiftUI

struct Dot: View {
    var circleRadius: CGFloat = 5
    
    var fillColor: Color

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let midX = geometry.size.width / 2
                let midY = geometry.size.height / 2
                path.move(to: CGPoint(x: midX, y: 0))
                path.addLine(to: CGPoint(x: midX, y: midY - self.circleRadius))
                path.addEllipse(in: CGRect(center: CGPoint(x: midX, y: 0), radius: self.circleRadius))
            }
            .fill(self.fillColor)
        }
    }
}

struct Pointer: Shape {
    var circleRadius: CGFloat = 5
    func path(in rect: CGRect) -> Path {
        Path { p in
            
            p.move(to: CGPoint(x: rect.midX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY - circleRadius))
            p.addEllipse(in: CGRect(center: CGPoint(x: rect.midX, y: rect.minY), radius: circleRadius))
//p.addEllipse(in: CGRect(center: rect.center, radius: circleRadius))
//            p.move(to: CGPoint(x: rect.midX, y: rect.midY + circleRadius))
//            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY + rect.height / 10))
        }
        
    }
}
