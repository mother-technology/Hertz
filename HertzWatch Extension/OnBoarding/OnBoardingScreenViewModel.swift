import Foundation
import CoreGraphics

class OnBoardingScreenViewModel {
    private(set) var cards: [OnBoardCard] = []
    
    func newCard(image: String, width: CGFloat = 42.0, height: CGFloat = 42.0, text: String) {
        cards.append(OnBoardCard(image: image, width: width, height: height, text: text))
    }
}
