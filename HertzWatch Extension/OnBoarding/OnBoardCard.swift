import Foundation
import CoreGraphics

struct OnBoardCard: Identifiable {
    let id = UUID()
    let image: String
    let width: CGFloat
    let height: CGFloat
    let text: String
}
