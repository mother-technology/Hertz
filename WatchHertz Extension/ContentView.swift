import SwiftUI

struct ContentView: View {
    @ObservedObject var model = HertzModel()

    var body: some View {
        GeometryReader { gr in
            VStack {
                AnalogClockFace()
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
