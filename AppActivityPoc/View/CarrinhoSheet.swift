//
//  CarrinhoSheet.swift
//  AppActivityPoc
//
//  Created by João Duque Nardelli Wandermuren on 29/10/26.
//

import SwiftUI

/// Sheet de carrinho
struct CarrinhoSheet: View {
    
    @Environment(\.dismiss) private var dismiss

    @Binding var carrinho: [Pratos: Int]

    @State var manager = PedidoManager()
    
    var mesaNumber: Int? = nil

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
                Button {
                    manager.iniciarPedido(mesa: mesaNumber ?? 0)
                } label: {
                    Spacer()
                    Text("Fazer pedido")
                    Spacer()
                }
                .padding()
                .glassEffect(.regular.interactive())
                .padding(.horizontal)
                
                Button {
                    Task {
                        await manager.encerrar()
                    }
                } label: {
                    Spacer()
                    Text("Remover pedido")
                    Spacer()
                }
                .padding()
                .glassEffect(.regular.interactive())
                .padding(.horizontal)
            }
            .navigationTitle("Seu Pedido")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    CarrinhoSheet(carrinho: .constant([:]))
        .sheet(isPresented: .constant(true)) {
            CarrinhoSheet(carrinho: .constant([:]))
        }
}
