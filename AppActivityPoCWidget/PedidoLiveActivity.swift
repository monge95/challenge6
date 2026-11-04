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
                    .foregroundStyle(.primary)
                Text("Entrega às \(context.state.time, style: .time)")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .activityBackgroundTint(Color(uiColor: .secondarySystemBackground))
            .activitySystemActionForegroundColor(Color.primary)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                        Text("Mesa \(context.attributes.table)")
                        
                  
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.time, style: .time)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    ComponentLoad(load: context.state.load)
                                          .padding(.top, 4)
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



