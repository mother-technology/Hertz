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
        Text("Test")
            .font(
                Font.system(
                    size: 14,
                    weight: .regular,
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
