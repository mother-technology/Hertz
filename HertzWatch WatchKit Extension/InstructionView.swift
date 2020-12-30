import SwiftUI

struct InstructionView: View {
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 5) {
                Group {
                    Text("Instructions")
                        .font(
                            Font.system(
                                size: 16,
                                weight: .bold,
                                design: .default
                            ).monospacedDigit().smallCaps()
                        )
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("⏣ Select your speed and number of revolutions.")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            )
                            .monospacedDigit()
                        )
                }
                    Group {
                        Text("⏣ Focus on the ")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            )
                            .monospacedDigit()
                        ) +
                        Text("red ")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .bold,
                                design: .default
                            )
                            .monospacedDigit()
                        )
                        .foregroundColor(.red) +
                        Text("dot.")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            ).monospacedDigit()
                        )
                        
                    Text("⏣ Breath in over ")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            ).monospacedDigit()) +
                        Text("blue ")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .bold,
                                design: .default
                            ).monospacedDigit())
                        .foregroundColor(Color("BreathIn")) +
                    Text("ticks. ")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            ).monospacedDigit())
                        Text("⏣ Pause breathing over ")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            ).monospacedDigit()) +
                        Text("white ")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .bold,
                                design: .default
                            ).monospacedDigit())
                        .foregroundColor(Color("BreathHold")) +
                        Text("ticks. ")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            ).monospacedDigit())
                        Text("⏣ Breath out over ")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            ).monospacedDigit()) +
                        Text("dark red ")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .bold,
                                design: .default
                            ).monospacedDigit())
                        .foregroundColor(Color("BreathOut")) +
                        Text("ticks, drop your shoulders, and relax.")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            ).monospacedDigit())
                        Text("⏣ Periodically nudge the digital crown to keep the screen alive.")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            ).monospacedDigit())
                }
                Group {
                    Text("Tips & Tricks")
                        .font(
                            Font.system(
                                size: 16,
                                weight: .bold,
                                design: .default
                            ).monospacedDigit().smallCaps()
                        )
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("⏣ ")
                    .font(
                        Font.system(
                            size: 16,
                            weight: .bold,
                            design: .default
                        )
                        .monospacedDigit()
                    )
                    .foregroundColor(.BreathIn) +
                    Text("Best to practise straight after waking, directly after exercise, and just before sleep.")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            )
                            .monospacedDigit()
                        )
                    Text("⏣ ")
                    .font(
                        Font.system(
                            size: 16,
                            weight: .bold,
                            design: .default
                        )
                        .monospacedDigit()
                    )
                    .foregroundColor(.BreathIn) +
                    Text("Regular short sessions beat sporadic long ones.")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            )
                            .monospacedDigit()
                        )
                    Text("⏣ ")
                    .font(
                        Font.system(
                            size: 16,
                            weight: .bold,
                            design: .default
                        )
                        .monospacedDigit()
                    )
                    .foregroundColor(.BreathIn) +
                    Text("Practise in a calm, comfortable environment without distractions.")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            )
                            .monospacedDigit()
                        )
                    Text("⏣ ")
                    .font(
                        Font.system(
                            size: 16,
                            weight: .bold,
                            design: .default
                        )
                        .monospacedDigit()
                    )
                    .foregroundColor(.BreathIn) +
                    Text("If you feel dizzy, take a moment to rest after pracise.")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            )
                            .monospacedDigit()
                        )
                    Text("⏣ ")
                    .font(
                        Font.system(
                            size: 16,
                            weight: .bold,
                            design: .default
                        )
                        .monospacedDigit()
                    )
                    .foregroundColor(.BreathIn) +
                    Text("Relax your muscles as you breath out.")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            )
                            .monospacedDigit()
                        )
                    Text("⏣ ")
                    .font(
                        Font.system(
                            size: 16,
                            weight: .bold,
                            design: .default
                        )
                        .monospacedDigit()
                    )
                    .foregroundColor(.BreathIn) +
                    Text("Try to 'will' the dot to slow down as you breath out.")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            )
                            .monospacedDigit()
                        )
                    Text("⏣ ")
                    .font(
                        Font.system(
                            size: 16,
                            weight: .bold,
                            design: .default
                        )
                        .monospacedDigit()
                    )
                    .foregroundColor(.BreathIn) +
                    Text("As you recognise the sensation of activating your vagus, practise its activation also without the app.")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            )
                            .monospacedDigit()
                        )
                    Text("Good luck!")
                        .font(
                            Font.system(
                                size: 16,
                                weight: .bold,
                                design: .default
                            ).monospacedDigit().smallCaps()
                        )
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("www.csd.red")
                        .font(
                            Font.system(
                                size: 14,
                                weight: .ultraLight,
                                design: .default
                            )
                            .monospacedDigit()
                        )
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .background(
                    Color(.black)
                        .edgesIgnoringSafeArea(.all)
                )
            }
        }
    }
}


struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
