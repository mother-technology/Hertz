import SwiftUI

struct OnBoardingCardView: View {
    @Binding var isShowing: Bool
    
    let card: OnBoardCard
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top) {
                    Text(card.title)
                        .font(.title)
                    Spacer()
                }
    //            Image(card.image)
    //                .resizable()
    //                .scaledToFit()
                Text(card.text)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(.darkGray))
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
        OnBoardingCardView(isShowing: .constant(true), card: OnBoardCard(title: "HAJ", image: "xmark.circle.fill", text: "This is a long text, with the posiblih asdhad had adh lkjhad lkajhd k akjdh ak akjdha kjhasd k akdjhadkh kasd akjhd"))
    }
}
