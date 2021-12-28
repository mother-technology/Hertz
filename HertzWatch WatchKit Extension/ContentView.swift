import Combine
import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = false

    @AppStorage("OnBoardVersionViewed") var onBoardVersionViewed: Double = 0

    let onBoardingModel = OnBoardingData.build()

    @StateObject var model = ContentViewModel(hertzModel: HertzModel())
    @StateObject var workoutManager: WorkoutManager = .shared

    @State private var instructionsIsOpen: Bool = false

    @State private var revsIsFocused = false
    @State private var speedIsFocused = false

    var body: some View {
        ZStack {
            Group {
                if !model.isFinished {
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
                }
                if model.isRunning {
                    VStack {
                        Text("F: \(model.factor, specifier: "%.3f")")
                            .font(
                                Font.system(
                                    size: 10,
                                    weight: .regular,
                                    design: .default
                                ).monospacedDigit()
                            )
                        Text("Heart: \(model.heartRate, specifier: "%.0f")")
                            .font(
                                Font.system(
                                    size: 10,
                                    weight: .regular,
                                    design: .default
                                ).monospacedDigit()
                            )
                        Text("Diff: \(model.diffAvgMinHeartRate, specifier: "%.1f")")
                            .font(
                                Font.system(
                                    size: 10,
                                    weight: .regular,
                                    design: .default
                                ).monospacedDigit()
                            )
                    }
                }
                
                // Ready to be started
                if !model.isRunning {
                    //... and has yet not finished
                    if !model.isFinished {
                        VStack {
                            // --- Buttons for starting the app
                            Spacer()
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
                            
                            // --- End button for starting the app

                            Spacer()
                            // ---- Buttons for adjusting revolution and speed
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
                            // --- Ending with buttons for adjusting revs and speed
                        }
                    } //Finished!
                    else {
                        ScrollView {
                            VStack(alignment: .center) {
                                Image("success").resizable()
                                    .frame(width: 60.0, height: 60.0)
                                    .padding(.top, 10)
                                Spacer()
                                VStack {
                                    Text("Well done!")
                                        .font(
                                            Font.system(
                                                size: 14,
                                                weight: .bold,
                                                design: .default
                                            ).monospacedDigit()
                                        )
                                        .padding(.top, 15)
                                    Text("Keep up the training and you will notice a difference in your relaxation")
                                        .font(
                                            Font.system(
                                                size: 8,
                                                weight: .regular,
                                                design: .default
                                            ).monospacedDigit()
                                        )
                                        .multilineTextAlignment(.center)
                                        .padding(.top, 3)
                                        .padding(.bottom, 3)

                                    if model.beforeHeartRate > 0 && model.afterHeartRate > 0 &&
                                        model.beforeHeartRate > model.afterHeartRate {
                                        Text("Your heart rate")
                                            .font(
                                                Font.system(
                                                    size: 14,
                                                    weight: .bold,
                                                    design: .default
                                                ).monospacedDigit()
                                            )
                                            .padding(.top, 10)

                                        // ---- Text for showing heart beat
                                        HStack {
                                            VStack {
                                                Text("BEFORE")
                                                    .font(
                                                        Font.system(
                                                            size: 8,
                                                            weight: .light,
                                                            design: .default
                                                        ).monospacedDigit()
                                                    )
                                                    .kerning(0.5)
                                                    .padding(.bottom, 2)
                                                Text("\(model.beforeHeartRate)")
                                                    .font(
                                                        Font.system(
                                                            size: 12,
                                                            weight: .bold,
                                                            design: .default
                                                        ).monospacedDigit()
                                                    )
                                                    .padding()
                                                    .background(Color("LightPink"))
                                                    .cornerRadius(7)
                                            }

                                            VStack {
                                                Text("AFTER")
                                                    .font(
                                                        Font.system(
                                                            size: 8,
                                                            weight: .regular,
                                                            design: .default
                                                        ).monospacedDigit()
                                                    )
                                                    .kerning(0.5)
                                                    .padding(.bottom, 2)
                                                Text("\(model.afterHeartRate)")
                                                    .font(
                                                        Font.system(
                                                            size: 12,
                                                            weight: .bold,
                                                            design: .default
                                                        ).monospacedDigit()
                                                    )
                                                    .padding()
                                                    .background(Color("LightPink"))
                                                    .cornerRadius(7)
                                            }
                                            .padding(.leading, 3)
                                        }
                                        .padding(.top, 15)
                                        .padding(.bottom, 15)
                                        // --- Ending with text to show heart beat
                                    }

                                    Button(action: {
                                        model.returnToStart()
                                    }) {
                                        Image(systemName: "arrow.backward")
                                            .frame(width: 35, height: 32)
                                            .foregroundColor(Color.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 7)
                                                    .stroke(Color("SliderGreen"), lineWidth: 1)
                                            )
                                    }
                                    .frame(width: 35, height: 32)
                                    .background(Color.black)
                                    .padding(.top, 10)
                                    .padding(.bottom, 30)
                                }
                            }
                            .frame(maxWidth: 110, maxHeight: .infinity)
                            .background(
                                Color(.black)
                                    .edgesIgnoringSafeArea(.all)
                            )
                        }
                    }
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
        .onAppear {
            if onBoardVersionViewed < onBoardingModel.version {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        showOnboarding.toggle()
                        onBoardVersionViewed = onBoardingModel.version
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
