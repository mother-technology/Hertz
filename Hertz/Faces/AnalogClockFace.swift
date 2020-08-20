import SwiftUI

struct AnalogClockFace: View {
//    var time: TimeInterval = 0

    func tick(at tick: Int) -> some View {
        VStack {
            Rectangle()
                .fill(Color.primary)
                .opacity(tick % 20 == 0 ? 1 : 0.4)
                .frame(width: 2, height: tick % 4 == 0 ? 15 : 7)
            Spacer()
        }
        .rotationEffect(Angle.degrees(Double(tick) / 240 * 360))
    }

//    func pointer() -> some View {
//        Pointer()
//            .stroke(Color.orange, lineWidth: 2)
//            .rotationEffect(Angle.degrees(Double(time) * 360 / 60))
//    }

    var body: some View {
        ZStack {
            ForEach(0 ..< 60 * 4) { tick in
                self.tick(at: tick)
            }
        }
    }
}

struct AnalogClockFace_Previews: PreviewProvider {
    static var previews: some View {
        AnalogClockFace()
            .background(Color.white)
            .previewLayout(.fixed(width: 500, height: 500))
    }
}
