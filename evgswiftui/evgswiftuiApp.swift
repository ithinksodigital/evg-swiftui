//
//  evgswiftuiApp.swift
//  evgswiftui
//
//  Created by Rafał Pawelec on 16/02/2025.
//

import SwiftUI
import Evergage

@main
struct evgswiftuiApp: App {
    init() {
        let success = EvergageManager.shared.initialize()
        print(success ? "🟢 Evergage initialized successfully!" : "🔴 Evergage failed to initialize!")
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
    }
}
