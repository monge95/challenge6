//
//  AppActivityPocClipApp.swift
//  AppActivityPocClip
//
//  Created by João Duque Nardelli Wandermuren on 28/10/26.
//

import SwiftUI

@main
struct AppActivityPocClipApp: App {

    /// Número da mesa, que pode ser nulo caso a invocação seja sem link
    @State private var mesaNumber: Int?

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(mesaNumber: mesaNumber)
                    /// Modificador que recebe a invocação
                    .onContinueUserActivity(
                        NSUserActivityTypeBrowsingWeb
                    ) { activity in
                        /// Verificar se a invocação via URL existe
                        guard let url = activity.webpageURL else {
                            return
                        }
                        mesaNumber = tableNumber(from: url)
                    }
            }
        }
    }

    /// Pegar número da mesa da invocação
    private func tableNumber(from url: URL) -> Int? {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)

        if let table = components?.queryItems?.first(where: {
            $0.name == "mesa"
        })?.value,
            let number = Int(table)
        {
            return number
        }

        let pathComponents = url.pathComponents
        if let mesaIndex = pathComponents.firstIndex(of: "mesa"),
            pathComponents.indices.contains(mesaIndex + 1)
        {
            return Int(pathComponents[mesaIndex + 1])
        }

        return nil
    }
}
