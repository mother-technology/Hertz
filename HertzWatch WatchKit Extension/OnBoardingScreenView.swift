import SwiftUI

struct OnBoardingScreenView: View {
    @Binding var isPresenting: Bool
    var model: OnBoardingScreenViewModel

    var body: some View {
        VStack {
            TabView {
                ForEach(model.cards) { card in
                    OnBoardingCardView(isShowing: $isPresenting, card: card)
                        .padding()
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}

struct OnBoardingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingScreenView(isPresenting: .constant(true), model: OnBoardingData.build())
    }
}
