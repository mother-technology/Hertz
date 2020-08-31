import SwiftUI

struct ContentView: View {
    @ObservedObject var model = HertzViewModel()
    @ObservedObject var hrvModel = WorkoutManager()

    @State var sessionInProgress = false

    let dot = Color(red: 1, green: 0, blue: 0)
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                ZStack {
                    TickFace(ticks: self.model.ticks)
                        .frame(
                            width: geometry.size.width - 0,
                            height: geometry.size.width - 1
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

                    Dot(circleRadius: 6, fillColor: self.dot)
                        .rotationEffect(self.model.currentAngle)
                        .frame(
                            width: geometry.size.width - 38,
                            height: geometry.size.width - 12
                        )

                    
                    Text("\(self.hrvModel.heartrate, specifier: "%.1f") ♥")
                        .font(
                            Font.system(
                                size: 26,
                                weight: .regular,
                                design: .default
                            ).monospacedDigit()
                        )
                        .opacity(self.sessionInProgress ? 1 : 0)
                        .overlay(
                            RunButton(action: {
                                self.sessionInProgress = true
                                self.model.start()
                                self.hrvModel.startWorkout()
                            }).onAppear() {
                                self.hrvModel.requestAuthorization()
                            }
                            .offset(CGSize(width: 0, height: self.sessionInProgress ? geometry.size.height : 0))
                            .animation(.easeInOut(duration: 0.3))
                        )
                }
                .frame(width: geometry.size.width, height: geometry.size.width)
            }
            .padding()
            .background(
                Color(
                    red: 0,
                    green: 0,
                    blue: 0
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
