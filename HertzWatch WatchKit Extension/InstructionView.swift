import SwiftUI

struct InstructionView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading)    {
            Text("Instructions")
                .font(
                    Font.system(
                        size: 16,
                        weight: .bold,
                        design: .default
                        ).monospacedDigit().smallCaps()
                )
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 2)
            Text("1. Focus on the")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    )
                    .monospacedDigit()
                    ) +
            Text(" red ")
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
            Text("2. Breath in over")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit()) +
            Text(" blue ")
                .font(
                    Font.system(
                        size: 14,
                        weight: .bold,
                        design: .default
                    ).monospacedDigit())
                .foregroundColor(Color("BreathIn"))
            Text("ticks. ")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit())
            Text("3. Pause breathing over")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit()) +
            Text(" white ")
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
            Text("4. Breath out over")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit()) +
                Text(" dark red ")
                    .font(
                        Font.system(
                            size: 14,
                            weight: .bold,
                            design: .default
                        ).monospacedDigit())
                    .foregroundColor(Color("BreathOut")) +
            Text("ticks.")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit())
            Text("Tips")
                .font(
                    Font.system(
                        size: 16,
                        weight: .bold,
                        design: .default
                        ).monospacedDigit().smallCaps()
                )
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 2)
            Text("To keep the screen on, keep a finger rested on the digital crown, and give it an occasional scroll.")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit())
            Text("Practise first thing in the morning, last thing at night, and directly after phsyical exercise.")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit())
        }

            .background(
            Color(.black)
            .edgesIgnoringSafeArea(.all)
        )
        }
    }
}
                

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
