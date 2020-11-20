import SwiftUI

struct TickFace: View {
    var model: ContentViewModel
    
    var body: some View {
        ZStack {
            ForEach(self.model.ticks, id: \.self) { tick in
                VStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(
                            self.model.getColor(for: tick.segment)
                        )
                        .frame(width: 7, height: 20)
                    Spacer()
                }
                .rotationEffect(tick.angle)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1.0, contentMode: .fit)
    }
}

struct TickFace_Previews: PreviewProvider {
    static var previews: some View {
        TickFace(model: ContentViewModel(hertzModel: HertzModel()))
    }
}
