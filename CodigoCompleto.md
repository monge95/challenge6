# 📂 Diretório: ./AppActivityPoc

### 📄 Arquivo: ContentView.swift
```swift
import SwiftUI
import ActivityKit

struct ContentView: View {

    @State private var activity: Activity<PedidoAttributes>?
    @State var searchText: String = ""

    var body: some View {
        VStack {
//            HStack {
//                VStack {
//                    Text("Titulo")
//                        .font(.title)
//                        .bold()
//                    Text("Subtitulo")
//                        .font(.title3)
//                }
//
//                Spacer()
//
//                Circle()
//                    .frame(maxWidth: 50, maxHeight: 50)
//            }
//            TextField("", text: $searchText)
//                .padding(11)
//                .background(.fill.secondary, in: .capsule)
//
//            LazyVGrid(
//                columns: [GridItem(), GridItem()],
//                alignment: .center,
//                spacing: 10
//            ) {
//                ForEach(Pratos.allCases, id: \.self) { prato in
//                    PratoComponent(nome: prato.rawValue)
//                }
//            }
            
            
            Button("fazer pedido") {
                guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }

                let attributes = PedidoAttributes(
                    table: 3,
                    orderTime: Date()
                )

                let startState = PedidoAttributes.ContentState(
                    state: .preparando,
                    time: Calendar.current.date(byAdding: .minute, value: 50, to: Date()) ?? Date(),
                    texRequest: "Seu pedido está sendo processado"
                )

                do {
                    activity = try Activity.request(
                        attributes: attributes,
                        content: ActivityContent(state: startState, staleDate: nil)
                    )
                    print("Atividade iniciada: \(activity?.id ?? "?")")
                } catch {
                    print("Erro ao iniciar: \(error)")
                }
            }
            .padding()
            
            Button("parar pedido") {
                guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }
                
                for atual in Activity<PedidoAttributes>.activities {
                    Task { await atual.end(dismissalPolicy: .immediate) }
                }
            }
//            Spacer()
        }
        .padding()
    }
}

enum Pratos: String, CaseIterable {
    case marmita = "Marmita"
    case carne_panela = "Carne de Panela"
    case escondidinho = "Escondidinho"
    case feijao_farofa = "Feijão com Farofa"
}

#Preview {
    ContentView()
}

```

---

### 📄 Arquivo: MyApp.swift
```swift
import SwiftUI

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
    }
}

```

---

### 📄 Arquivo: PratoComponent.swift
```swift
//
//  PratoComponentr.swift
//  AppActivityPoc
//
//  Created by João Duque Nardelli Wandermuren on 29/10/26.
//

import SwiftUI

struct PratoComponent: View {
    
    let nome: String
    
    var body: some View {
        VStack {
            HStack {
                Text(nome)
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.gray)
                    .overlay(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.fill.secondary)
                    }
            )
        }
    }
}

#Preview {
    PratoComponent(nome: "Nome bom")
}

```

---

# 📂 Diretório: ./AppActivityPocClip

### 📄 Arquivo: AppActivityPocClipApp.swift
```swift
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

```

---

# 📂 Diretório: ./AppActivityPoCWidget

### 📄 Arquivo: AppActivityPoCWidgetBundle.swift
```swift
//
//  AppActivityPoCWidgetBundle.swift
//  AppActivityPoCWidget
//
//  Created by João Duque Nardelli Wandermuren on 29/10/26.
//

import WidgetKit
import SwiftUI

@main
struct AppActivityPoCWidgetBundle: WidgetBundle {
    var body: some Widget {
        PedidoLiveActivity()
    }
}

```

---

### 📄 Arquivo: PedidoAttributes.swift
```swift
//
//  PedidoAttributes.swift
//  Untitled Project
//
//  Created by Pedro Monge Silveira on 28/10/26.
//

import SwiftUI
import ActivityKit

enum StateRequest: Codable, Hashable {
    case preparando
    case aCaminho
    case entregue
}

struct PedidoAttributes: ActivityAttributes{
    
    let table: Int
    let orderTime: Date
    
    struct ContentState: Codable & Hashable{
        
        var state: StateRequest
        var time: Date
        var texRequest: String
        
    }
}

```

---

### 📄 Arquivo: PedidoLiveActivity.swift
```swift
//
//  PedidoLiveActivity.swift
//  PedidoLiveActivity Project
//
//  Created by Pedro Monge Silveira on 29/10/26.
//

import SwiftUI
import WidgetKit

struct PedidoLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PedidoAttributes.self) { context in
          
            VStack(alignment: .leading, spacing: 8) {
                Text("Mesa \(context.attributes.table)")
                    .font(.headline)
                Text(textoDoEstado(context.state.state))
                Text("Entrega às \(context.state.time, style: .time)")
            }
            .padding()
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("Mesa \(context.attributes.table)")
                }
                DynamicIslandExpandedRegion(.center) {
                    Text(textoDoEstado(context.state.state))
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.time, style: .time)
                }
            } compactLeading: {
                Image(systemName: "fork.knife")
            } compactTrailing: {
                Text(context.state.time, style: .timer)
            } minimal: {
                Image(systemName: "fork.knife")
            }
        }
    }
}

func textoDoEstado(_ estado: StateRequest) -> String {
    switch estado {
    case .preparando: return "Seu pedido está sendo preparado 👨‍🍳"
    case .aCaminho:   return "Seu pedido está a caminho 🛵"
    case .entregue:   return "Pedido entregue! Bom apetite ✅"
    }
}

#Preview(
    "Order preparing",
    as: .content,
    using: PedidoAttributes(
        table: 3,
        orderTime: Date()
    ),
    widget: {
        PedidoLiveActivity()
    },
    contentStates: {
        PedidoAttributes.ContentState(
            state: .preparando,
            time: Date().addingTimeInterval(1800),
            texRequest: "Preparing your order"
        )

        PedidoAttributes.ContentState(
            state: .aCaminho,
            time: Date().addingTimeInterval(900),
            texRequest: "Your order is on the way"
        )

        PedidoAttributes.ContentState(
            state: .entregue,
            time: Date(),
            texRequest: "Order delivered"
        )
    }
)

```

---

