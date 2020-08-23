import SwiftUI

struct ContentView: View {
    @ObservedObject var model = HertzViewModel()

    let dot = Color(red: 0.7215301991, green: 0.2244053185, blue: 0.3535325527)
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                ZStack {
                    Circle()
                        .fill(
                            Color(
                                red: 0.1258122921,
                                green: 0.1453048885,
                                blue: 0.1794787049
                            ))
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
                            width: geometry.size.width - 20,
                            height: geometry.size.width - 20
                        )

                    Dot(circleRadius: 7, fillColor: self.dot)
                        .rotationEffect(self.model.currentAngle)
                        .frame(
                            width: geometry.size.width - 38,
                            height: geometry.size.width - 38
                        )
                }
                .frame(width: geometry.size.width, height: geometry.size.width)
            }
            .padding()
            .background(
                Color(
                    red: 0.08547224849,
                    green: 0.1101305559,
                    blue: 0.1441726089
                )
                .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
