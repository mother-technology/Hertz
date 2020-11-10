import SwiftUI

struct OnBoardingScreenView: View {
    @Binding var isPresenting: Bool
    var model: OnBoardingScreenViewModel
    
    var body: some View {
        GeometryReader { geometry in
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
}

struct OnBoardingScreenView_Previews: PreviewProvider {
    static var data: OnBoardingScreenViewModel {
        let model = OnBoardingScreenViewModel()
        model.newCard(title: "Test", image: "Image", text: "Alot of text just slipping on by ad by")
        model.newCard(title: "Test", image: "Image", text: "Alot of text just slipping on by ad by")
        model.newCard(title: "Test", image: "Image", text: "Alot of text just slipping on by ad by")

        return model
    }
    
    static var previews: some View {
        OnBoardingScreenView(isPresenting: .constant(true), model: data)
    }
}
