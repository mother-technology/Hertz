import SwiftUI

struct Triangle: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = min(geometry.size.width, geometry.size.height)
                let middle = width / 2
                
                path.addLines([
                    CGPoint(x: middle, y: geometry.size.height),
                    CGPoint(x: 0, y: 0),
                    CGPoint(x: geometry.size.width, y: 0)
                ])
            }
        }
    }
}

struct Triangle_Previews: PreviewProvider {
    static var previews: some View {
        Triangle()
        .frame(width: 400, height: 400)
    }
}
