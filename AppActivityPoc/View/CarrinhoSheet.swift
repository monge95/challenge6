//
//  CarrinhoSheet.swift
//  AppActivityPoc
//
//  Created by João Duque Nardelli Wandermuren on 29/10/26.
//

import SwiftUI

struct CarrinhoSheet: View {

    @Binding var carrinho: [Pratos: Int]

    @State var manager = PedidoManager()

    var body: some View {
        NavigationView {
            VStack {
                let pratosNoCarrinho =
                    carrinho
                    .filter { $0.value > 0 }
                    .sorted { $0.value > $1.value }

                if pratosNoCarrinho.isEmpty {
                    ContentUnavailableView(
                        "Nenhum prato no carrinho",
                        systemImage: "cart"
                    )
                } else {
                    List {
                        ForEach(pratosNoCarrinho, id: \.key) { key, value in
                            HStack {
                                Text(key.rawValue)
                                Spacer()
                                HStack {
                                    Button {
                                        carrinho[key, default: 0] = max(
                                            0,
                                            value - 1
                                        )
                                    } label: {
                                        Image(systemName: "minus.circle")
                                    }
                                    .buttonStyle(.plain)

                                    Text(String(value))

                                    Button {
                                        carrinho[key, default: 0] = value + 1
                                    } label: {
                                        Image(systemName: "plus.circle")
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                }
                Button("Fazer pedido") {
                    manager.iniciarPedido(mesa: 3)
                }
                Button("Remover pedidos") {
                    Task {
                        await manager.encerrar()
                    }
                }
            }
            .navigationTitle("Carrinho")
        }
    }
}
