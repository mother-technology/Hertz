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
                ).monospacedDigit()
            )
            Text("Focus on the red dot.")
                .font(
                    Font.system(
                        size: 14,
                        weight: .bold,
                        design: .default
                    ).monospacedDigit()
                )
            Text("As it passes over blue ticks, breath in slowly. As it passes over white ticks, arrest breathing without tensing. As it passes over red ticks, breath out through your nose.")
            .font(
                Font.system(
                    size: 14,
                    weight: .ultraLight,
                    design: .default
                ).monospacedDigit()
            )
        }
    }
}
                

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
