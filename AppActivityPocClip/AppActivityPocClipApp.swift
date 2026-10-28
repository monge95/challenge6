//
//  AppActivityPocClipApp.swift
//  AppActivityPocClip
//
//  Created by João Duque Nardelli Wandermuren on 28/10/26.
//

import SwiftUI

@main
struct AppActivityPocClipApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onContinueUserActivity(
                    NSUserActivityTypeBrowsingWeb
                ) { activity in
                    guard let url = activity.webpageURL else {
                        return
                    }

                    print("App Clip opened with: \(url)")
                }
        }
    }
}
