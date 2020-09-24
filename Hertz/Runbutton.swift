import SwiftUI
import UIKit

struct RunStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        Circle()
            .fill(Color(UIColor.clear))
            .overlay(
                configuration.label
                    .foregroundColor(.white)
                    .font(Font.system(size: 50, weight: .ultraLight, design: .default))
            )
//            .frame(width: 100, height: 100)
    }
}

struct RunButton: View {
    var action: (() -> Void) = {}

    var body: some View {
        Button(action: { self.action() }) {
            Image(systemName: "arrowtriangle.right.circle")
        }
        .buttonStyle(RunStyle())
    }
}

struct RunButton_Previews: PreviewProvider {
    static var previews: some View {
        RunButton()
    }
}
