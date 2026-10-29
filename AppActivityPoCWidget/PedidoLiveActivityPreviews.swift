import ActivityKit
import SwiftUI
import WidgetKit

// This file belongs only to the full app's widget extension.
// Sharing the preview declaration with the Clip makes its host ambiguous.
#Preview(
    "Pedido",
    as: .dynamicIsland(.compact),
    using: PedidoAttributes(table: 3, orderTime: .now)
) {
    PedidoLiveActivity()
} contentStates: {
    PedidoAttributes.ContentState(
        state: .preparando,
        time: .now.addingTimeInterval(1800),
        texRequest: "Preparando"
    )
    PedidoAttributes.ContentState(
        state: .aCaminho,
        time: .now.addingTimeInterval(900),
        texRequest: "A caminho"
    )
    PedidoAttributes.ContentState(
        state: .entregue,
        time: .now,
        texRequest: "Entregue"
    )
}

#Preview(
    "Pedido",
    as: .dynamicIsland(.expanded),
    using: PedidoAttributes(table: 3, orderTime: .now)
) {
    PedidoLiveActivity()
} contentStates: {
    PedidoAttributes.ContentState(
        state: .preparando,
        time: .now.addingTimeInterval(1800),
        texRequest: "Preparando"
    )
    PedidoAttributes.ContentState(
        state: .aCaminho,
        time: .now.addingTimeInterval(900),
        texRequest: "A caminho"
    )
    PedidoAttributes.ContentState(
        state: .entregue,
        time: .now,
        texRequest: "Entregue"
    )
}

#Preview(
    "Pedido",
    as: .dynamicIsland(.minimal),
    using: PedidoAttributes(table: 3, orderTime: .now)
) {
    PedidoLiveActivity()
} contentStates: {
    PedidoAttributes.ContentState(
        state: .preparando,
        time: .now.addingTimeInterval(1800),
        texRequest: "Preparando"
    )
    PedidoAttributes.ContentState(
        state: .aCaminho,
        time: .now.addingTimeInterval(900),
        texRequest: "A caminho"
    )
    PedidoAttributes.ContentState(
        state: .entregue,
        time: .now,
        texRequest: "Entregue"
    )
}
