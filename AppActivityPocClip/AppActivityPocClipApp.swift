//
//  AppActivityPocClipApp.swift
//  AppActivityPocClip
//
//  Created by João Duque Nardelli Wandermuren on 28/10/26.
//

import SwiftUI

@main
struct AppActivityPocClipApp: App {
    @State private var mesaNumber: Int?

    var body: some Scene {
        WindowGroup {
            ContentView(mesaNumber: mesaNumber)
                .onContinueUserActivity(
                    NSUserActivityTypeBrowsingWeb
                ) { activity in
                    guard let url = activity.webpageURL else {
                        return
                    }
                    mesaNumber = tableNumber(from: url)
                }
        }
    }

    private func tableNumber(from url: URL) -> Int? {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)

        if let table = components?.queryItems?.first(where: { $0.name == "mesa" })?.value,
           let number = Int(table) {
            return number
        }

        let pathComponents = url.pathComponents
        if let mesaIndex = pathComponents.firstIndex(of: "mesa"),
           pathComponents.indices.contains(mesaIndex + 1) {
            return Int(pathComponents[mesaIndex + 1])
        }

        return nil
    }
}
