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
    
    
    struct ContentState: Codable & Hashable{
        
        var state: StateRequest
        var time: Date
        var texRequest: String
        var load: Int
        
    }
    
    let table: Int
    let orderTime: Date
    
}


func textoDoEstado(_ estado: StateRequest) -> String {
    switch estado {
    case .preparando: return "Seu pedido está sendo preparado 👨‍🍳"
    case .aCaminho:   return "Seu pedido está a caminho 🛵"
    case .entregue:   return "Pedido entregue! Bom apetite ✅"
    }
}
