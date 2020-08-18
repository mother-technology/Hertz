import Foundation
import Combine

func tickMiddleware() -> Middleware<AppState, AppAction> {
    let maxSeconds: TimeInterval = 60
    var seconds: TimeInterval = 0
    
    var timer: Timer?
    
    return { state, action, dispatch in
        switch action {
        case .timerStart:
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                seconds += timer.timeInterval
                seconds = min(seconds, maxSeconds)

                if seconds == maxSeconds {
                    seconds = 0
                }

                dispatch(.timerTick(seconds))
            }
        case .timerStop:
            timer?.invalidate()
        default:
            break
        }
    }
}
