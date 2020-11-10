import Foundation

class OnBoardingScreenViewModel {
    private(set) var cards: [OnBoardCard] = []
    
    func newCard(title: String, image: String, text: String) {
        cards.append(OnBoardCard(title: title, image: image, text: text))
    }
}
