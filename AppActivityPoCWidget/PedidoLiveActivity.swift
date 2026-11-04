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
          
            VStack(alignment: .trailing, spacing: 8) {
                Text("Mesa \(context.attributes.table)")
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(textoDoEstado(context.state.state))
                Text("Previsão de Entrega às \(context.state.time, style: .time)")
            }
            .padding()
            .activityBackgroundTint(Color(uiColor: .secondarySystemBackground))
            .activitySystemActionForegroundColor(Color.primary)
        } dynamicIsland: { context in
            DynamicIsland{
                DynamicIslandExpandedRegion(.leading) {
                        Text("Mesa \(context.attributes.table)")
                        .padding(.leading, 10)
                        
                  
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.time, style: .time)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    ComponentLoad(load: context.state.load)
                        .padding(.horizontal, )
                }
            } compactLeading: {
                
            } compactTrailing: {
                Text(context.state.time, style: .timer)
            } minimal: {
                Image(systemName: "fork.knife")
            }
        }
    }
}



