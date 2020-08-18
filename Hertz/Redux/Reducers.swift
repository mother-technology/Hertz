typealias Reducer<State, Action> = (inout State, Action) -> Void

func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch(action) {
    case .timerTick(let timerIntervall):
        state.seconds = timerIntervall
    case .timerStart, .timerStop:
        break
    }
}
