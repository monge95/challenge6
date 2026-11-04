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
            load: 1
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

    func atualizar(estado novoEstado: StateRequest, load novoLoad: Int) async {
        guard let activity else { return }
    
        let novo = PedidoAttributes.ContentState(
            state: novoEstado,
            time: activity.content.state.time,
            texRequest: textoDoEstado(novoEstado),
            load: novoLoad
        )

        await activity.update(ActivityContent(state: novo, staleDate: nil))

        self.estado = novoEstado
        self.load = novoLoad
    }

    func encerrar() async {
        progressTask?.cancel()
        await activity?.end(nil, dismissalPolicy: .default)
        activity = nil
        load = 0
    }

    private func iniciarProgresso() {
        progressTask?.cancel()
        progressTask = Task {
            try? await Task.sleep(for: .seconds(5))
            guard !Task.isCancelled else { return }
            await atualizar(estado: .aCaminho, load: 2)

            try? await Task.sleep(for: .seconds(5))
            guard !Task.isCancelled else { return }
            await atualizar(estado: .aCaminho, load: 3)

            try? await Task.sleep(for: .seconds(5))
            guard !Task.isCancelled else { return }
            await atualizar(estado: .entregue, load: 4)

            try? await Task.sleep(for: .seconds(3))
            guard !Task.isCancelled else { return }
            await encerrar()
        }
    }

}
