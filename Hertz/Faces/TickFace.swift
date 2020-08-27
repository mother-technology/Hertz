import SwiftUI

struct TickFace: View {
    var ticks: [Tick] = []

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(self.ticks, id: \.self) { tick in
                    VStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(tick.color.opacity(tick.opacity))
                            .frame(width: 7, height: 20)
                            .shadow(color: .black, radius: 1, x: -0.5, y: -0.5)
                        Spacer()
                    }
                    .rotationEffect(tick.angle)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct TickFace_Previews: PreviewProvider {
    static var previews: some View {
        TickFace()
            .padding()
            .background(Color.white)
            .previewLayout(.fixed(width: 500, height: 500))
    }
}
