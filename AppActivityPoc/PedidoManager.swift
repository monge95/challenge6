//
//  PedidoManager.swift
//  AppActivityPoc
//
//  Created by Pedro Monge Silveira on 03/11/26.
//

import SwiftUI
import ActivityKit
import Observation

@MainActor
@Observable
final class PedidoManager {

    private var activity: Activity<PedidoAttributes>?
    private var progressTask: Task<Void, Never>?

    var load: Int = 0
    var estado: StateRequest = .preparando

    func iniciarPedido(mesa: Int) {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }

        let atributos = PedidoAttributes(table: mesa, orderTime: .now)

        let estadoInicial = PedidoAttributes.ContentState(
            state: .preparando,
            time: Date().addingTimeInterval(300),
            texRequest: "Seu pedido está sendo preparado",
            load: 1,
            left: "12"
        )

        do {
            activity = try Activity.request(
                attributes: atributos,
                content: ActivityContent(state: estadoInicial, staleDate: nil)
            )
            load = 1
            estado = .preparando
            iniciarProgresso()
        } catch {
            print("Erro ao iniciar: \(error)")
        }
    }

    func atualizar(estado novoEstado: StateRequest, load novoLoad: Int,  left timer: String) async {
        guard let activity else { return }
    
        let novo = PedidoAttributes.ContentState(
            state: novoEstado,
            time: activity.content.state.time,
            texRequest: textoDoEstado(novoEstado),
            load: novoLoad,
            left: timer
            
        )

        await activity.update(ActivityContent(state: novo, staleDate: nil))

        self.estado = novoEstado
        self.load = novoLoad
    }

    func encerrar() async {
        progressTask?.cancel()
        progressTask = nil

        // The manager may not hold the Activity instance if it was recreated,
        // so end every live Pedido activity owned by this app.
        for pedidoActivity in Activity<PedidoAttributes>.activities {
            await pedidoActivity.end(nil, dismissalPolicy: .immediate)
        }

        activity = nil
        load = 0
    }

    private func iniciarProgresso() {
        progressTask?.cancel()
        progressTask = Task {
            try? await Task.sleep(for: .seconds(10))
            guard !Task.isCancelled else { return }
            await atualizar(estado: .aCaminho, load: 2, left: "8")

            try? await Task.sleep(for: .seconds(10))
            guard !Task.isCancelled else { return }
            await atualizar(estado: .aCaminho, load: 3, left: "5")

            try? await Task.sleep(for: .seconds(10))
            guard !Task.isCancelled else { return }
            await atualizar(estado: .entregue, load: 4, left: "chegou")

            try? await Task.sleep(for: .seconds(5))
            guard !Task.isCancelled else { return }
            await encerrar()
        }
    }

}
