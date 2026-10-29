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
