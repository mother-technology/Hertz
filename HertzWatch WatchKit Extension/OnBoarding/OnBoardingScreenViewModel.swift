import CoreGraphics
import Foundation

class OnBoardingScreenViewModel {
    private(set) var cards: [OnBoardCard] = []

    // This needs to be bumped to the next version if you want the onboardingscreen to be shown again
    // Only bump the major version always, i.e. 2.0 becomes 3.0 unt so weiter
    let version = 2.0

    func newCard(image: String, width: CGFloat = 55.0, height: CGFloat = 55.0, text: String) {
        cards.append(OnBoardCard(image: image, width: width, height: height, text: text))
    }
}
