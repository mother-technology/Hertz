import SwiftUI
import UIKit

struct RunStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        Circle()
            .fill(Color(UIColor.clear))
            .overlay(
                configuration.label
                    .foregroundColor(.white)
                    .font(Font.system(size: 36, weight: .black, design: .default))
            )
            .frame(width: 100, height: 100)
    }
}

struct RunButton: View {
    var action: (() -> Void) = {}

    var body: some View {
        Button(action: { self.action() }) {
            Text("➠")
        }
        .buttonStyle(RunStyle())
    }
}

struct RunButton_Previews: PreviewProvider {
    static var previews: some View {
        RunButton()
    }
}
