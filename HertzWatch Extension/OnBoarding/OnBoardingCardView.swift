import SwiftUI

struct OnBoardingCardView: View {
    @Binding var isShowing: Bool
    
    let card: OnBoardCard
    
    var body: some View {
        ScrollView {
            VStack {
    //            Image(card.image)
    //                .resizable()
    //                .scaledToFit()
                Text(card.text)
                    .font(.system(size: 14, weight: .light))
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
            .padding(.top, 3)
        }
    }
}

struct OnBoardingCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingCardView(isShowing: .constant(true), card: OnBoardCard(image: "xmark.circle.fill", text: "This is a long text, with the posiblih asdhad had adh lkjhad lkajhd k akjdh ak akjdha kjhasd k akdjhadkh kasd akjhd"))
    }
}
