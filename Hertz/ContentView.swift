import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ContentViewModel(hertzModel: HertzModel())

    let dot = Color(red: 1, green: 0, blue: 0)
    let bc = Color(
        red: 0,
        green: 0,
        blue: 0
    )

    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Just to push down the tickface
                Rectangle()
                    .fill(self.bc)
                    .frame(width: geometry.size.width, height: 20)
                ZStack {
                    TickFace(model: self.model)
                        .frame(
                            width: geometry.size.width - 10,
                            height: geometry.size.width - 80
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

                    Dot(circleRadius: 7, fillColor: self.dot)
                        .rotationEffect(self.model.currentAngle)
                        .frame(
                            width: geometry.size.width - 93,
                            height: geometry.size.width - 93
                        )
                }
                .frame(width: geometry.size.width, height: geometry.size.width)
                Spacer()
            }
            .background(
                Color(
                    red: 0,
                    green: 0,
                    blue: 0
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
