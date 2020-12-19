import Combine
import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = false
    
    @AppStorage("OnboardBeenViewed") var hasOnboarded = false
    let onBoardingModel = OnBoardingData.build()
    
    @ObservedObject var model = ContentViewModel(hertzModel: HertzModel())
    @ObservedObject var workoutManager: WorkoutManager = .shared
    
    @Environment(\.scenePhase) var scenePhase
    
    @State private var instructionsIsOpen: Bool = false

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
                    if model.isFinished {
                        VStack(alignment: .center) {
                            //Spacer()
                            Image("success-\(model.successImageIndex)").resizable()
                                .frame(width: 75.0, height: 55.0)
                            if model.averageOfAllDifferences > 0 {
                                Text("AVERAGE SCORE: \(model.averageOfAllDifferences, specifier: "%.0f")" )
                                .kerning(0.7)
                                .padding(.top, 5)
                                .font(
                                    Font.system(
                                        size: 14,
                                        weight: .black,
                                        design: .default
                                        ).monospacedDigit()
                                     )
                            }
                            if model.maxOfAllDifferences > 0 {
                                Text("MAX SCORE: \(model.maxOfAllDifferences, specifier: "%.0f")")
                                    .kerning(0.7)
                                    .padding(.top, 5)
                                    .font(
                                        Font.system(
                                            size: 14,
                                            weight: .black,
                                            design: .default
                                            ).monospacedDigit()
                                         )
                            }
                            Text("I love Tomás!")
                                .font(
                                    Font.system(
                                        size: 12,
                                        weight: .light,
                                        design: .default
                                        ).monospacedDigit()
                                     )
                                .italic()
                                .foregroundColor(.gray)
                                .padding(.top, 1)
                                .multilineTextAlignment(.center)
                        }
                    }
                    else {
                        VStack {
                            Spacer()
                            Button {
                                model.start()
                            } label: {
                                Image(systemName: "arrowtriangle.right.circle")
                            }
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .font(Font.system(size: 50, weight: .ultraLight, design: .default))
                            .transition(
                                AnyTransition.opacity.animation(.easeInOut(duration: 1.0))
                            )
                            Spacer()
                            Text("\(model.digitalScrollAmountForRevolutions, specifier: "%.0f") ROTATIONS")
                                .kerning(1)
                                .font(
                                    Font.system(
                                        size: 14,
                                        weight: .black,
                                        design: .default
                                        ).monospacedDigit()
                                     )
                                //.padding(.top, 15)
                            Text("Adjust revolutions with the digital crown")
                                .font(
                                    Font.system(
                                        size: 12,
                                        weight: .light,
                                        design: .default
                                        ).monospacedDigit()
                                     )
                                .italic()
                                .foregroundColor(.gray)
                                .padding(.top, 1)
                                .multilineTextAlignment(.center)
                            .focusable()
                            .digitalCrownRotation($model.digitalScrollAmountForRevolutions, from: 1, through: 20, by: 1, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: true)
                        }
                    }
                } else {
                    VStack {
                        
                        Text("\(model.factor, specifier: "%.3f")")
                            .font(
                                Font.system(
                                    size: 16,
                                    weight: .regular,
                                    design: .default
                                ).monospacedDigit()
                            )
                        Text("\(model.diffAvgMinHeartRate, specifier: "%.3f")")
                            .font(
                                Font.system(
                                    size: 16,
                                    weight: .regular,
                                    design: .default
                                ).monospacedDigit()
                            )
                        
                        Text("") //Mikey - how do I remove without getting error on focusable and crownRotation below?
                        .focusable()
                        .digitalCrownRotation($model.digitalScrollAmount, from: -2, through: 2, by: 1, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: true)
                     }
                    .transition(
                        AnyTransition.opacity.animation(.easeInOut(duration: 1.0))
                    )
                    
                }
            }
            .disabled(showOnboarding || instructionsIsOpen)
            .blur(radius: (showOnboarding || instructionsIsOpen) ? 3.0 : 0)
            
            if showOnboarding {
                OnBoardingScreenView(isPresenting: $showOnboarding, model: onBoardingModel)
            }
            
            BottomSheetView(isOpen: $instructionsIsOpen, maxHeight: 150, minHeight: 0) {
                VStack {
                    InstructionView()
                        .padding()
                }
            }
            .disabled(showOnboarding)
        }
        .background(
            Color(.black)
            .edgesIgnoringSafeArea(.all)
        )
        .onAppear {
            workoutManager.requestAuthorization()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                model.stop()
            }
        }
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
