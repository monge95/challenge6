//
//  AppActivityPocClipApp.swift
//  AppActivityPocClip
//
//  Created by João Duque Nardelli Wandermuren on 05/11/26.
//

import SwiftUI

@main
struct AppActivityPocClipApp: App {
    
    @State var mesaNumber: Int?
    
    var body: some Scene {
        WindowGroup {
            ContentView(mesaNumber: mesaNumber)
                .onContinueUserActivity(
                    NSUserActivityTypeBrowsingWeb
                ) { activity in
                    guard
                        let url = activity.webpageURL,
                        url.host == "meurestaurante.com.br",
                        url.pathComponents.count >= 3,
                        url.pathComponents[1] == "mesa",
                        let tableNumber = Int(url.pathComponents[2])
                    else {
                        return
                    }
                    
                    print(url)
                    print(tableNumber)
                    
                    mesaNumber = tableNumber
                    
                }
        }
    }
}
