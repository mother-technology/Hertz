import SwiftUI

@main
struct HertzWatchApp: App {
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
    }
}
