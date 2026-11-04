import SwiftUI
import ActivityKit

struct ContentView: View {

    @State private var activity: Activity<PedidoAttributes>?
    @State var searchText: String = ""
    @State private var manager = PedidoManager()

    var body: some View {
        VStack {
//            HStack {
//                VStack {
//                    Text("Titulo")
//                        .font(.title)
//                        .bold()
//                    Text("Subtitulo")
//                        .font(.title3)
//                }
//
//                Spacer()
//
//                Circle()
//                    .frame(maxWidth: 50, maxHeight: 50)
//            }
//            TextField("", text: $searchText)
//                .padding(11)
//                .background(.fill.secondary, in: .capsule)
//
//            LazyVGrid(
//                columns: [GridItem(), GridItem()],
//                alignment: .center,
//                spacing: 10
//            ) {
//                ForEach(Pratos.allCases, id: \.self) { prato in
//                    PratoComponent(nome: prato.rawValue)
//                }
//            }
            
            
         
            Button("Fazer pedido") {
                manager.iniciarPedido(mesa: 3)
            }
            .buttonStyle(.borderedProminent)

            Button("Cancelar") {
                Task { await manager.encerrar() }
            }
            .buttonStyle(.bordered)
            .disabled(manager.load == 0)
        }
    }
}

enum Pratos: String, CaseIterable {
    case marmita = "Marmita"
    case carne_panela = "Carne de Panela"
    case escondidinho = "Escondidinho"
    case feijao_farofa = "Feijão com Farofa"
}

#Preview {
    ContentView()
}
