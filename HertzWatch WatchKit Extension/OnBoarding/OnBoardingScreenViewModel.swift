import CoreGraphics
import Foundation

class OnBoardingScreenViewModel {
    private(set) var cards: [OnBoardCard] = []

    func newCard(image: String, width: CGFloat = 55.0, height: CGFloat = 55.0, text: String) {
        cards.append(OnBoardCard(image: image, width: width, height: height, text: text))
    }
}
