import SwiftUI


/// Componente do prato na ContentView
struct PratoComponent: View {
    let nome: String
    let onAdicionar: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color(uiColor: .systemGray4))
                .overlay(alignment: .bottom) {
                    HStack(alignment: .top, spacing: 8) {
                        Text(nome)
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .lineLimit(2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        #if APPCLIP
                            Button(action: onAdicionar) {
                                Image(systemName: "plus")
                                    .font(.headline.weight(.medium))
                                    .foregroundStyle(.white)
                                    .padding(8)
                                    .background(.gray, in: Circle())
                                    .contentShape(Circle())
                            }
                            .buttonStyle(.plain)
                            .frame(minWidth: 44, minHeight: 44)
                        #endif
                        
                    }
                    .padding(12)
                    .background(
                        Color(.secondarySystemBackground)
                    )
                }
                .aspectRatio(0.82, contentMode: .fit)
        }
        .clipShape(.rect(cornerRadius: 26))
        .contentShape(.rect(cornerRadius: 26))
    }
}

#Preview {
    PratoComponent(nome: "Carne de Panela", onAdicionar: {})
        .frame(width: 170)
        .padding()
}
