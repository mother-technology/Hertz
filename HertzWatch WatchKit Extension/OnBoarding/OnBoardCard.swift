import CoreGraphics
import Foundation

struct OnBoardCard: Identifiable {
    let id = UUID()
    let image: String
    let width: CGFloat
    let height: CGFloat
    let text: String
}
