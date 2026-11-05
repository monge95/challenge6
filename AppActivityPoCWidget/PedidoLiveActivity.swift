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
        // quando o celular esta desligado
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
            
            //configuraçoes do celular ligago
        } dynamicIsland: { context in
            // area maior com o celular aberto
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
                //linha superior cabe so uma palavra e uma imgem pequena na direita
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
              
                //bolinha a esquerda
            } minimal: {
                Image(systemName: "fork.knife")
            }
        }
    }
}



