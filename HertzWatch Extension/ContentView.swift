import Combine
import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ContentViewModel(hertzModel: HertzModel())

    @ObservedObject var workoutManager: WorkoutManager = .shared

    let dot = Color(red: 1, green: 0.2, blue: 0)

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    TickFace(model: self.model)
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.width
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
                                            Color.gray.opacity(0.7),
                                            Color.gray.opacity(0.8),
                                            Color.gray.opacity(1),
                                            Color.gray.opacity(0.9),
                                            Color.gray.opacity(0.8),
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

//                    VStack {
//                        Text("\(self.model.heartRate, specifier: "%.1f") ♥")
//                            .font(
//                                Font.system(
//                                    size: 20,
//                                    weight: .regular,
//                                    design: .default
//                                ).monospacedDigit()
//                            )
//                        
//                            Text("\(self.model.factor, specifier: "%.1f")")
//                                .font(
//                                    Font.system(
//                                        size: 18,
//                                        weight: .regular,
//                                        design: .default
//                                    ).monospacedDigit()
//                                )
//                    }
                    .opacity(self.model.isRunning ? 1 : 0)
                    .overlay(
                        RunButton(action: {
                            self.model.start()
                            self.workoutManager.startWorkout()
                        }).onAppear {
                            self.workoutManager.requestAuthorization()
                        }
                        .offset(
                            CGSize(
                                width: 0,
                                height: self.model.isRunning ? geometry.size.height : 0
                            )
                        )
                        .animation(.easeInOut(duration: 0.3))
                    )
                }
            }
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
