import SwiftUI

struct InstructionView: View {

    var body: some View {
        ScrollView {
        VStack {
            Text("Instructions")
                .font(
                    Font.system(
                        size: 16,
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
            Text("Breath in over ")
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
            Text(" ticks. ")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit()) +
            Text("Pause breathing over ")
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
            Text("Breath out over ")
                .font(
                    Font.system(
                        size: 14,
                        weight: .ultraLight,
                        design: .default
                    ).monospacedDigit()) +
            Text("dark red")
                .font(
                    Font.system(
                        size: 14,
                        weight: .bold,
                        design: .default
                    ).monospacedDigit())
                .foregroundColor(Color("BreathOut"))
            Text(" ticks, drop your shoulders, and relax.")
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
