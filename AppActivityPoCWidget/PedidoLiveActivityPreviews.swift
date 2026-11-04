import ActivityKit
import SwiftUI
import WidgetKit

// This file belongs only to the full app's widget extension.
// Sharing the preview declaration with the Clip makes its host ambiguous.
#Preview(
    "Pedido Compacto",
    as: .dynamicIsland(.compact),
    using: PedidoAttributes(table: 3, orderTime: .now)
) {
    PedidoLiveActivity()
} contentStates: {
    PedidoAttributes.ContentState(
        state: .preparando,
        time: .now.addingTimeInterval(1800),
        texRequest: "Preparando",
        load: 1
    )
    PedidoAttributes.ContentState(
        state: .aCaminho,
        time: .now.addingTimeInterval(900),
        texRequest: "A caminho", load: 2
    )
    PedidoAttributes.ContentState(
        state: .entregue,
        time: .now,
        texRequest: "Entregue", load: 4
    )
}

#Preview(
    "Pedido Expandido",
    as: .dynamicIsland(.expanded),
    using: PedidoAttributes(table: 3, orderTime: .now)
) {
    PedidoLiveActivity()
} contentStates: {
    PedidoAttributes.ContentState(
        state: .preparando,
        time: .now.addingTimeInterval(1800),
        texRequest: "Preparando", load: 1
        
    )
    PedidoAttributes.ContentState(
        state: .aCaminho,
        time: .now.addingTimeInterval(900),
        texRequest: "A caminho", load: 2
    )
    PedidoAttributes.ContentState(
        state: .entregue,
        time: .now,
        texRequest: "Entregue", load: 4
    )
}

#Preview(
    "Pedido Minimo",
    as: .dynamicIsland(.minimal),
    using: PedidoAttributes(table: 3, orderTime: .now)
) {
    PedidoLiveActivity()
} contentStates: {
    PedidoAttributes.ContentState(
        state: .preparando,
        time: .now.addingTimeInterval(1800),
        texRequest: "Preparando", load: 1
    )
    PedidoAttributes.ContentState(
        state: .aCaminho,
        time: .now.addingTimeInterval(900),
        texRequest: "A caminho", load: 4
    )
    PedidoAttributes.ContentState(
        state: .entregue,
        time: .now,
        texRequest: "Entregue", load: 4
    )
}
