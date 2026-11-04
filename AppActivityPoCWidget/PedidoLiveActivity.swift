//
//  PedidoLiveActivity.swift
//  PedidoLiveActivity Project
//
//  Created by Pedro Monge Silveira on 29/10/26.
//

import SwiftUI
import WidgetKit

/// Visualização da Live Activity
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
                    GeometryReader{geo in
                        Text("Mesa \(context.attributes.table)")
                            .padding(.leading, geo.size.width * 0.1)
                    }
                        
                  
                }
                DynamicIslandExpandedRegion(.bottom) {
                    ComponentLoad(load: context.state.load,left: context.state.left)
                        .padding(.horizontal)
                }
            } compactLeading: {
                switch context.state.state {
                case .aCaminho:
                    Text("A caminho")
                    
                case .entregue:
                    Text("chegou")
                    
                case .preparando:
                    Text("preparando")
                }
                
            } compactTrailing: {
              
            } minimal: {
                Image(systemName: "fork.knife")
            }
        }
    }
}



