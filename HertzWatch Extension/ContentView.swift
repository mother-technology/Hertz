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
                        .rotationEffect(model.currentAngle)
                    )
                
                Dot(circleRadius: 6, fillColor: Color(red: 1, green: 0, blue: 0))
                    .rotationEffect(model.currentAngle)
                    .padding(5)
                
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
                        Text("\(model.heartRate, specifier: "%.1f") ♥")
                            .font(
                                Font.system(
                                    size: 20,
                                    weight: .regular,
                                    design: .default
                                ).monospacedDigit()
                            )
                        Text("Scroll: \(model.digitalScrollAmount)")
                            .font(
                                Font.system(
                                    size: 18,
                                    weight: .regular,
                                    design: .default
                                ).monospacedDigit()
                            )
                        Text("\(model.factor, specifier: "%.1f")")
                            .font(
                                Font.system(
                                    size: 18,
                                    weight: .regular,
                                    design: .default
                                ).monospacedDigit()
                            )
                        
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
            hasOnboarded = false // DEBUG
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
