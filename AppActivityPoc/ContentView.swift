import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Bem vindo ao restaurante!")
            List {
                ForEach(Pratos.allCases, id: \.self) { prato in
                    Button {
                        print(prato.rawValue)
                    } label: {
                        Text(prato.rawValue)
                    }
                }
            }
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
