//
//  juke_iOSApp.swift
//  juke-iOS
//
//  Created by Mario Barrenechea on 3/28/22.
//

import SwiftUI

@main
struct juke_iOSApp: App {
    @StateObject private var session = SessionStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(session)
        }
    }
}
