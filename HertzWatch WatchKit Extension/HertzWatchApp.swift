import SwiftUI

@main
struct HertzWatchApp: App {
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            NavigationView {
                TimelineView(MetricsTimelineSchedule(from: Date())) { context in
                    ContentView(date: context.date)
                }
            }
        }
    }
}

private struct MetricsTimelineSchedule: TimelineSchedule {
    var startDate: Date

    init(from startDate: Date) {
        self.startDate = startDate
    }

    func entries(from startDate: Date, mode: TimelineScheduleMode) -> PeriodicTimelineSchedule.Entries {
        PeriodicTimelineSchedule(from: self.startDate, by: 1.0 / 30.0)
            .entries(from: startDate, mode: mode)
    }
}
