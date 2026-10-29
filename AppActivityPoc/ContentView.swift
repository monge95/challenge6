import SwiftUI
import ActivityKit

struct ContentView: View {

    @State private var activity: Activity<PedidoAttributes>?
    @State var searchText: String = ""

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
            
            
            Button("fazer pedido") {
                guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }

                let attributes = PedidoAttributes(
                    table: 3,
                    orderTime: Date()
                )

                let startState = PedidoAttributes.ContentState(
                    state: .preparando,
                    time: Calendar.current.date(byAdding: .minute, value: 50, to: Date()) ?? Date(),
                    texRequest: "Seu pedido está sendo processado"
                )

                do {
                    activity = try Activity.request(
                        attributes: attributes,
                        content: ActivityContent(state: startState, staleDate: nil)
                    )
                    print("Atividade iniciada: \(activity?.id ?? "?")")
                } catch {
                    print("Erro ao iniciar: \(error)")
                }
            }
            .padding()
            
            Button("parar pedido") {
                guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }
                
                for atual in Activity<PedidoAttributes>.activities {
                    Task { await atual.end(dismissalPolicy: .immediate) }
                }
            }
//            Spacer()
        }
        .padding()
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
