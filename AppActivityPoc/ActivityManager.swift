//
//  ActivityManager.swift
//  AppActivityPoc
//
//  Created by João Duque Nardelli Wandermuren on 03/11/26.
//

import Foundation
import ActivityKit

@MainActor
final class ActivityManager {
    static let shared = ActivityManager()

    private init() {}

    @discardableResult
    func startPedido(table: Int, orderTime: Date = .now) throws -> Activity<PedidoAttributes> {
        let attributes = PedidoAttributes(table: table, orderTime: orderTime)
        let initialState = PedidoAttributes.ContentState(
            state: .preparando,
            time: orderTime,
            texRequest: ""
        )
        let content = ActivityContent(state: initialState, staleDate: nil)

        return try Activity.request(
            attributes: attributes,
            content: content,
            pushType: nil
        )
    }

    func updatePedido(
        _ activity: Activity<PedidoAttributes>,
        state: StateRequest,
        time: Date,
        textRequest: String = ""
    ) async {
        let updatedState = PedidoAttributes.ContentState(
            state: state,
            time: time,
            texRequest: textRequest
        )
        await activity.update(ActivityContent(state: updatedState, staleDate: nil))
    }
    
    func endPedido(_ activity: Activity<PedidoAttributes>) async {
        await activity.end(nil, dismissalPolicy: .immediate)
    }

    func endAllPedidos() async {
        for activity in Activity<PedidoAttributes>.activities {
            await activity.end(nil, dismissalPolicy: .immediate)
        }
    }
}
