import Combine
import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = false

    @AppStorage("OnBoardVersionViewed") var onBoardVersionViewed: Double = 0

    let onBoardingModel = OnBoardingData.build()

    @ObservedObject var model = ContentViewModel(hertzModel: HertzModel())
    @ObservedObject var workoutManager: WorkoutManager = .shared

    @Environment(\.scenePhase) var scenePhase

    @State private var instructionsIsOpen: Bool = false

    @State private var revsIsFocused = false
    @State private var speedIsFocused = false

    var body: some View {
        ZStack {
            Group {
                TickFace(model: model)
                    .mask(
                        Arc(
                            startAngle: .degrees(303),
                            endAngle: .degrees(57),
                            clockwise: true,
                            radiusOffset: 0
                        )
                        .fill(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        .clear,
                                        Color.gray.opacity(0),
                                        Color.gray.opacity(0.2),
                                        Color.gray.opacity(0.3),
                                        Color.gray.opacity(0.5),
                                        Color.gray.opacity(1),
                                        Color.gray.opacity(0.7),
                                        Color.gray.opacity(0.3),
                                        Color.gray.opacity(0.2),
                                        Color.gray.opacity(0),
                                        .clear,
                                    ]
                                ),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .rotationEffect(model.currentAngle)
                    )

                Dot(circleRadius: 7)
                    .fill(Color(red: 0.888, green: 0, blue: 0))
                    .rotationEffect(model.currentAngle)
                    .padding(7.2)
                    .shadow(color: .black, radius: 0.7, x: 0.7, y: 0.7)

                if !model.isRunning {
                    if model.isFinished {
                        VStack(alignment: .center) {
                            Image("success-\(model.successImageIndex)").resizable()
                                .frame(width: 75.0, height: 55.0)
                                .padding(.top, 10)
                            Spacer()
                            VStack {
                                if model.maxOfAllDifferences > 0 {
                                    Text("RESULT")
                                        .font(
                                            Font.system(
                                                size: 10,
                                                weight: .light,
                                                design: .default
                                            ).monospacedDigit()
                                        )
                                        .kerning(0.5)
                                        .padding(.top, 5)
                                    Text("\(model.maxOfAllDifferences, specifier: "%.0f")")
                                        .font(
                                            Font.system(
                                                size: 18,
                                                weight: .regular,
                                                design: .default
                                            ).monospacedDigit()
                                        )
                                }
                                Spacer()
                                // .padding(.trailing, 7)
//                                VStack {
//                                    if model.trainingTime > 0 {
//                                        Text("TIME")
//                                            .font(
//                                                Font.system(
//                                                    size: 10,
//                                                    weight: .light,
//                                                    design: .default
//                                                ).monospacedDigit()
//                                            )
//                                            .kerning(0.5)
//                                            .padding(.top, 5)
//                                        Text("\(model.trainingTime, specifier: "%.1f")")
//                                            .font(
//                                                Font.system(
//                                                    size: 18,
//                                                    weight: .regular,
//                                                    design: .default
//                                                ).monospacedDigit()
//                                            )
//                                    }
                                // .padding(.leading, 7)
                            }
                            Button(action: {
                                model.returnToStart()

                            }) {
                                Text("Once more?")
                                    .font(
                                        Font.system(
                                            size: 16,
                                            weight: .regular,
                                            design: .default
                                        ).monospacedDigit()
                                    )
                                    .frame(width: 110, height: 50)
                                    .background(Color.black)
                            }
                            
                            .frame(width: 110, height: 35)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                            .offset(y: -5)
                            .padding(.top, 10)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            Color(.black)
                                .edgesIgnoringSafeArea(.all)
                        )
                    } else {
                        VStack {
                            Button {
                                model.start()
                            } label: {
                                Image(systemName: "arrowtriangle.right.circle")
                            }
                            .buttonStyle(PlainButtonStyle())
                            .font(Font.system(size: 50, weight: .ultraLight, design: .default))
                            .transition(
                                AnyTransition.opacity.animation(.easeInOut(duration: 1.0))
                            )
                            .offset(y: 27.0)
                            Spacer()

                            HStack {
                                VStack {
                                    Text("REVS")
                                        .font(
                                            Font.system(
                                                size: 10,
                                                weight: .light,
                                                design: .default
                                            ).monospacedDigit()
                                        )
                                        .kerning(0.5)
                                        .padding(.bottom, 2)
                                    Text("\(model.digitalScrollAmountForRevolutions, specifier: "%.0f")")
                                        .frame(width: 35, height: 32)
                                        .background(Color.black)
                                        .font(
                                            Font.system(
                                                size: 18,
                                                weight: .regular,
                                                design: .default
                                            ).monospacedDigit()
                                        )
                                        .focusable(true, onFocusChange: { isFocused in
                                            revsIsFocused = isFocused
                                        })
                                        .digitalCrownRotation($model.digitalScrollAmountForRevolutions, from: 7, through: 99, by: 1, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: true)
                                        .frame(width: 35, height: 32)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 7)
                                                .stroke(revsIsFocused ? Color("SliderGreen") : Color.white, lineWidth: 1)
                                        )
                                }
                                .padding(.trailing, 3)

                                VStack {
                                    Text("SPEED")
                                        .font(
                                            Font.system(
                                                size: 10,
                                                weight: .regular,
                                                design: .default
                                            ).monospacedDigit()
                                        )
                                        .kerning(0.5)
                                        .padding(.bottom, 2)
                                    Text("\(model.digitalScrollAmountForSpeed, specifier: "%.0f")")
                                        .frame(width: 35, height: 32)
                                        .background(Color.black)
                                        .font(
                                            Font.system(
                                                size: 18,
                                                weight: .regular,
                                                design: .default
                                            ).monospacedDigit()
                                        )
                                        .focusable(true, onFocusChange: { isFocused in
                                            speedIsFocused = isFocused
                                        })
                                        .digitalCrownRotation($model.digitalScrollAmountForSpeed, from: 1, through: 5, by: 1, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: true)
                                    .frame(width: 35, height: 32)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(speedIsFocused ? Color("SliderGreen") : Color.white, lineWidth: 1)
                                    )
                                }
                                .padding(.leading, 3)
                            }
                            .padding(.bottom, 2)
                        }
                    }
                }
//                else {
//                    VStack {
//                        Text("\(model.factor, specifier: "%.3f")")
//                            .font(
//                                Font.system(
//                                    size: 16,
//                                    weight: .regular,
//                                    design: .default
//                                ).monospacedDigit()
//                            )
//                        Text("\(model.diffAvgMinHeartRate, specifier: "%.3f")")
//                            .font(
//                                Font.system(
//                                    size: 16,
//                                    weight: .regular,
//                                    design: .default
//                                ).monospacedDigit()
//                            )
//                    }
//                    .transition(
//                        AnyTransition.opacity.animation(.easeInOut(duration: 1.0))
//                    )
//                }
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
            if onBoardVersionViewed < Bundle.main.bundleShortVersion {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        showOnboarding.toggle()
                        onBoardVersionViewed = Bundle.main.bundleShortVersion
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
