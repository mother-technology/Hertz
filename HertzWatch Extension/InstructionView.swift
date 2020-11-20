import SwiftUI

struct InstructionView: View {

    var body: some View {
        VStack {
            Text("Instructions")
                .font(
                    Font.system(
                        size: 18,
                        weight: .bold,
                        design: .default
                        ).monospacedDigit().smallCaps()
                )
            Text("Focus on the ")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    )
                    .monospacedDigit()
                    ) +
            Text("red")
                .font(
                    Font.system(
                        size: 14,
                        weight: .bold,
                        design: .default
                    )
                    .monospacedDigit()
                    )
                .foregroundColor(.red) +
            Text(" dot.")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit()
                )
            Text("As it passes over ")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit()) +
            Text("blue")
                .font(
                    Font.system(
                        size: 14,
                        weight: .bold,
                        design: .default
                    ).monospacedDigit())
                .foregroundColor(Color("BreathIn"))
            Text(" ticks, breath in slowly.")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit())
            Text("As it passes over ")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit()) +
            Text("white")
                .font(
                    Font.system(
                        size: 14,
                        weight: .bold,
                        design: .default
                    ).monospacedDigit())
                .foregroundColor(Color("BreathHold"))
            Text(" ticks, arrest breathing without tensing. ")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit())
            Text("As it passes over ")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit()) +
            Text("brown")
                .font(
                    Font.system(
                        size: 14,
                        weight: .bold,
                        design: .default
                    ).monospacedDigit())
                .foregroundColor(Color("BreathOut"))
            Text(" ticks, breath out through your nose.")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit())
        }
    }
}
                

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
