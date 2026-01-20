//
//  ContentView.swift
//  juke-iOS
//
//  Created by Mario Barrenechea on 3/28/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var session: SessionStore

    var body: some View {
        Group {
            if session.isAuthenticated {
                SearchDashboardView(session: session)
            } else {
                AuthView(session: session)
            }
        }
        .animation(.easeInOut, value: session.isAuthenticated)
        .environmentObject(session)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionStore())
    }
}
