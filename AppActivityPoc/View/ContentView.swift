import ActivityKit
import SwiftUI

struct ContentView: View {

    @State var searchText: String = ""

    @State var carrinho: [Pratos: Int] = [
        .carne_panela: 0,
        .escondidinho: 0,
        .feijao_farofa: 0,
        .marmita: 0,
    ]

    @State var showCarrinho: Bool = false

    var mesaNumber: Int? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Restaurante")
                            .font(.largeTitle.bold())

                        Text(
                            mesaNumber.map { "Mesa \($0)" }
                                ?? "Top 10 restaurantes"
                        )
                        .font(.title3)
                    }

                    Spacer()

                    Button {
                        showCarrinho.toggle()
                    } label: {
                        Image(systemName: "cart.fill")
                            .font(.title2)
                            .foregroundStyle(.primary)
                            .frame(width: 56, height: 56)
                            .background(.quaternary, in: Circle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Abrir carrinho")
                }

                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    TextField("Buscar", text: $searchText)
                    Image(systemName: "mic.fill")
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 16)
                .frame(height: 54)
                .background(.fill.secondary, in: .capsule)

                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 12),
                        GridItem(.flexible(), spacing: 12),
                    ],
                    alignment: .center,
                    spacing: 16
                ) {
                    ForEach(Pratos.allCases, id: \.self) { prato in
                        PratoComponent(nome: prato.rawValue) {
                            carrinho[prato, default: 0] += 1
                            showCarrinho.toggle()
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 28)
            .padding(.bottom, 24)
        }
        .background(Color(.systemBackground))
        .sheet(isPresented: $showCarrinho) {
            CarrinhoSheet(carrinho: $carrinho, mesaNumber: mesaNumber)
        }
    }
}

#Preview {
    ContentView()
}
