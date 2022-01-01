import SwiftUI

struct OnBoardingCardView: View {
    @Binding var isShowing: Bool

    let card: OnBoardCard

    var body: some View {
        ScrollView {
            VStack {
                Image(card.image)
                    .resizable()
                    .frame(width: card.width, height: card.height)
                    .scaledToFill()
                    .padding(.bottom, 10)
                Text(card.text)
                    .font(.system(size: 15, weight: .light))
                Spacer()
            }
            .padding(.horizontal)
            .background(Rectangle()
                .fill(Color(.black))
            )
            Button("Dismiss") {
                withAnimation {
                    isShowing = false
                }
            }
            .padding(.top, 5)
        }
    }
}

struct OnBoardingCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingCardView(isShowing: .constant(true), card: OnBoardingData.build().cards.first!)
    }
}
