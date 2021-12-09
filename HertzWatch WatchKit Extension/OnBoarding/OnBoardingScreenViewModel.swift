import CoreGraphics
import Foundation

class OnBoardingScreenViewModel {
    private(set) var cards: [OnBoardCard] = []

    // This needs to be bumped to the next version if you want the onboardingscreen to be shown again
    let version = 1.1

    func newCard(image: String, width: CGFloat = 55.0, height: CGFloat = 55.0, text: String) {
        cards.append(OnBoardCard(image: image, width: width, height: height, text: text))
    }
}
