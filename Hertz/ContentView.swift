import SwiftUI

struct ContentView: View {
    @ObservedObject var model = HertzViewModel()

    let dot = Color(red: 0.7215301991, green: 0.2244053185, blue: 0.3535325527)
    let bc = Color(
        red: 0.1258122921,
        green: 0.1453048885,
        blue: 0.1794787049
    )
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Circle()
                        .fill(self.bc)
                        .overlay(
                            Circle()
                                .stroke(
                                    Color(
                                        red: 0.1529411765,
                                        green: 0.1725490196,
                                        blue: 0.2039215686
                                    ),
                                    lineWidth: 2
                                )
                        )
                        .frame(
                            width: geometry.size.width - 10,
                            height: geometry.size.width - 10
                        )

                    TickFace(ticks: self.model.ticks)
                        .frame(
                            width: geometry.size.width - 100,
                            height: geometry.size.width - 100
                        )
                        .mask(
                            Arc(
                                startAngle: .degrees(312),
                                endAngle: .degrees(47),
                                clockwise: true,
                                radiusOffset: 0
                            )
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [
                                            .clear,
                                            Color.gray.opacity(0.1),
                                            Color.gray.opacity(0.2),
                                            Color.gray.opacity(0.3),
                                            Color.gray.opacity(0.4),
                                            Color.gray.opacity(1),
                                            Color.gray.opacity(0.4),
                                            Color.gray.opacity(0.3),
                                            Color.gray.opacity(0.2),
                                            Color.gray.opacity(0.1),
                                            .clear,
                                        ]
                                    ),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .rotationEffect(self.model.currentAngle)
                        )

                    Dot(circleRadius: 9, fillColor: self.dot)
                        .rotationEffect(self.model.currentAngle)
                        .frame(
                            width: geometry.size.width - 120,
                            height: geometry.size.width - 120
                        )
                }
                .frame(width: geometry.size.width, height: geometry.size.width)
                Spacer()
            }
            .background(
                Color(
                    red: 0.08547224849,
                    green: 0.1101305559,
                    blue: 0.1441726089
                )
                .edgesIgnoringSafeArea(.all))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
