import Combine
import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = false
    
    @AppStorage("OnboardBeenViewed") var hasOnboarded = false
    let onBoardingModel = OnBoardingData.build()
    
    @ObservedObject var model = ContentViewModel(hertzModel: HertzModel())
    @ObservedObject var workoutManager: WorkoutManager = .shared
    
    var body: some View {
        ZStack {
            Group {
                TickFace(model: model)
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
                                        Color.gray.opacity(0.6),
                                        Color.gray.opacity(0.9),
                                        Color.gray.opacity(0.5),
                                        Color.gray.opacity(0.4),
                                        Color.gray.opacity(0.3),
                                        Color.gray.opacity(0.1),
                                        .clear,
                                    ]
                                ),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .rotationEffect(model.currentAngle)
                    )
                
                Dot(circleRadius:7)
                    .fill(Color(red: 0.777, green: 0, blue: 0))
                    .rotationEffect(model.currentAngle)
                    .padding(7.2)
                    .shadow(color: .red, radius: 0.1, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)

                if !model.isRunning {
                    Button {
                        model.start()
                    } label: {
                        Image(systemName: "arrowtriangle.right.circle")
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.white)
                    .font(Font.system(size: 50, weight: .ultraLight, design: .default))
                    .transition(
                        AnyTransition.opacity.animation(.easeInOut(duration: 1.0))
                    )
                } else {
                    VStack {
//                        Text("\(model.diffAvgMinHeartRate, specifier: "%.3f")")
//                            .font(
//                                Font.system(
//                                    size: 18,
//                                    weight: .regular,
//                                    design: .default
//                                ).monospacedDigit()
//                            )
//                        Text("\(model.heartRate, specifier: "%.1f") ♥")
//                            .font(
//                                Font.system(
//                                    size: 16,
//                                    weight: .regular,
//                                    design: .default
//                                ).monospacedDigit()
//                            )
//                        Text("\(model.averageHeartRateInOrHold, specifier: "%.1f") Avg.♥")
//                            .font(
//                                Font.system(
//                                    size: 16,
//                                    weight: .regular,
//                                    design: .default
//                                ).monospacedDigit()
//                            )
//                        Text("Scroll: \(model.digitalScrollAmount, specifier: "%.1f") Scr")
//                            .font(
//                                Font.system(
//                                    size: 16,
//                                    weight: .regular,
//                                    design: .default
//                                ).monospacedDigit()
//                            )
//                        Text("\(model.factor, specifier: "%.3f")")
//                            .font(
//                                Font.system(
//                                    size: 16,
//                                    weight: .regular,
//                                    design: .default
//                                ).monospacedDigit()
//                            )
//
                        
                    }
                    .transition(
                        AnyTransition.opacity.animation(.easeInOut(duration: 1.0))
                    )
                }
            }
            .disabled(showOnboarding)
            .blur(radius: showOnboarding ? 3.0 : 0)
            
            if showOnboarding {
                OnBoardingScreenView(isPresenting: $showOnboarding, model: onBoardingModel)
            }
        }
        .focusable()
        .digitalCrownRotation($model.digitalScrollAmount, from: -2, through: 2, by: 1, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: true)
        .background(
            Color(.black)
            .edgesIgnoringSafeArea(.all)
        )
        .onAppear {
            if !hasOnboarded {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        showOnboarding.toggle()
                        hasOnboarded = true
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
