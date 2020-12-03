//
//  HertzWatchApp.swift
//  HertzWatch WatchKit Extension
//
//  Created by Mikael Hultgren on 2020-12-02.
//

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
