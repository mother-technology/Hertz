import Foundation

enum AppAction {
    case timerStart
    case timerStop
    case timerTick(TimeInterval)
}
