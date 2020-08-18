import SwiftUI

struct ContentView: View {
    @ObservedObject var model = HertzModel()

    var body: some View {
        GeometryReader { gr in
            VStack {
                AnalogClockFace(time: self.model.seconds)
                    .frame(width: gr.size.width, height: gr.size.width)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
