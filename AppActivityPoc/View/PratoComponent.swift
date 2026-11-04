import SwiftUI

struct PratoComponent: View {
    let nome: String
    let onAdicionar: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color(uiColor: .systemGray4))
                .aspectRatio(1.15, contentMode: .fit)

            HStack(alignment: .top, spacing: 8) {
                Text(nome)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Button(action: onAdicionar) {
                    Image(systemName: "plus")
                        .font(.headline.weight(.medium))
                        .foregroundStyle(.white)
                        .frame(width: 36, height: 36)
                        .background(.gray, in: Circle())
                        .contentShape(Circle())
                }
                .buttonStyle(.plain)
                .fixedSize()
                .accessibilityLabel("Adicionar \(nome) ao carrinho")
            }
            .padding(12)
            .frame(maxWidth: .infinity, minHeight: 62, alignment: .topLeading)
            .background(Color(uiColor: .secondarySystemBackground))
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

#Preview {
    PratoComponent(nome: "Carne de Panela", onAdicionar: {})
        .frame(width: 170)
        .padding()
}
