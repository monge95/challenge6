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
