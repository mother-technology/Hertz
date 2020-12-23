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
    @State private var isSpeedSelected = false
    @State private var isRevolutionSelected = false
    
    @State private var buttonColorSpeed: Color = Color.white
    @State private var buttonColorRevolutions: Color = Color.white
    
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
                    .shadow(color: .red, radius: 0.1, x: 0.0, y: 0.0)
                
                if !model.isRunning {
                    if model.isFinished {
                        VStack(alignment: .center) {
                            //Spacer()
                            Image("success-\(model.successImageIndex)").resizable()
                                .frame(width: 75.0, height: 55.0)
                            if model.maxOfAllDifferences > 0 {
                                Text("PEAK SCORE: \(model.maxOfAllDifferences, specifier: "%.0f")")
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
                            .font(Font.system(size: 50, weight: .ultraLight, design: .default))
                            .transition(
                                AnyTransition.opacity.animation(.easeInOut(duration: 1.0))
                            )
                            
                            HStack {
                                VStack {
                                    Text("SPEED")
                                        .font(
                                            Font.system(
                                                size: 11,
                                                weight: .regular,
                                                design: .default
                                            ).monospacedDigit()
                                        )
                                        .kerning(0.5)
                                        .padding(.bottom, 2)
                                    Button(action: {
                                        self.buttonColorSpeed = Color("SliderGreen")
                                        self.buttonColorRevolutions = Color.white
                                        isSpeedSelected = true
                                        isRevolutionSelected = false
                                    }) {
                                        Text("\(model.digitalScrollAmountForSpeed, specifier: "%.0f")")
                                            .frame(width:40, height: 40)
                                            .background(Color.black)
                                            .font(
                                                Font.system(
                                                    size: 20,
                                                    weight: .regular,
                                                    design: .default
                                                ).monospacedDigit()
                                            )
                                    }
                                    .frame(width:40, height: 40)
                                    .overlay(
                                                RoundedRectangle(cornerRadius: 7)
                                                    .stroke(buttonColorSpeed, lineWidth: 1)
                                            )
                                }
                                .padding(.trailing, 3)
                                VStack {
                                    Text("REVS")
                                        .font(
                                            Font.system(
                                                size: 11,
                                                weight: .light,
                                                design: .default
                                            ).monospacedDigit()
                                        )
                                        .kerning(0.5)
                                        .padding(.bottom, 2)
                                    Button(action: {
                                        self.buttonColorRevolutions = Color("SliderGreen")
                                        self.buttonColorSpeed = Color.white
                                        isSpeedSelected = false
                                        isRevolutionSelected = true
                                    
                                    }) {
                                        Text("\(model.digitalScrollAmountForRevolutions, specifier: "%.0f")")
                                            .frame(width:40, height: 40)
                                            .background(Color.black)
                                            .font(
                                                Font.system(
                                                    size: 20,
                                                    weight: .regular,
                                                    design: .default
                                                ).monospacedDigit()
                                            )
                                    }
                                    .frame(width:40, height: 40)
                                    .overlay(
                                                RoundedRectangle(cornerRadius: 7)
                                                    .stroke(buttonColorRevolutions, lineWidth: 1)
                                            )
                                }
                                .padding(.leading, 3)
                            }
                            .padding(.top, 5)
                        }
                        
//                        if isSpeedSelected {
//                            self.focusable(true)
//                            self.digitalCrownRotation($model.digitalScrollAmountForSpeed, from: 2, through: 20, by: 1, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: true)
//                        }
//                        if isRevolutionSelected {
//                            self.focusable(true)
//                            self.digitalCrownRotation($model.digitalScrollAmountForRevolutions, from: 1, through: 10, by: 1, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: true)
//                        }
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
