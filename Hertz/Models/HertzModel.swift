import Foundation

class HertzModel: ObservableObject {
    @Published var seconds: TimeInterval = 0
    let maxSeconds: TimeInterval = 60

    init() {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.seconds += timer.timeInterval
            self.seconds = min(self.seconds, self.maxSeconds)

            if self.seconds == self.maxSeconds {
                self.seconds = 0
            }
        }
    }
}
