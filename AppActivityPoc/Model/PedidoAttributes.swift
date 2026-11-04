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
