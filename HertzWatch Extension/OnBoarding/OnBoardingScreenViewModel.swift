import Foundation

class OnBoardingScreenViewModel {
    private(set) var cards: [OnBoardCard] = []
    
    func newCard(image: String, text: String) {
        cards.append(OnBoardCard(image: image, text: text))
    }
}
