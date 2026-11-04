//
//  ComponentLoad.swift
//  AppActivityPoc
//
//  Created by Pedro Monge Silveira on 29/10/26.
//
import SwiftUI

struct ComponentLoad: View {

    let load: Int
    var left: String = ""
    var total: Int = 4
    var spacing: CGFloat = 6
    var diameter: CGFloat = 10
    var text: [String] = ["confirmando", "preparando", "entregando", "entregue"]

    private var chegou: Bool {
          load >= total || left.lowercased() == "chegou"
      }

      private var titulo: String {
          if chegou { return "Seu pedido chegou" }
          guard !left.isEmpty else { return "Seu pedido está sendo preparado" }
          return "Seu pedido chega em \(left) min"
      }
    
    var body: some View {
        VStack(spacing: 8) {
            
          
            Text(titulo)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            GeometryReader { geometry in
                let stepCount = min(total, text.count)
                let stepWidth = geometry.size.width / CGFloat(max(stepCount, 1))
                let lineWidth = max(0, stepWidth - diameter)
                
            
          
              ZStack(alignment: .bottomLeading) {
                    ForEach(0..<max(stepCount - 1, 0), id: \.self) { index in
                        let startX = CGFloat(index) * stepWidth + stepWidth / 2 + diameter / 2
                        let isConnected = load > index + 1

                        Capsule()
                            .fill(Color.primary.opacity(0.2))
                            .frame(width: lineWidth, height: 2)
                            .overlay(alignment: .leading) {
                                Capsule()
                                    .fill(.blue)
                                    .frame(width: isConnected ? lineWidth : 0, height: 2)
                            }
                            .position(x: startX + lineWidth / 2, y: diameter / 2)
                    }

                    HStack(spacing: 0) {
                        ForEach(0..<stepCount, id: \.self) { index in
                            Circle()
                                .fill(load > index ? .blue : Color.primary.opacity(0.2))
                                .frame(width: diameter, height: diameter)
                                .frame(width: stepWidth)
                        }
                    }
                }
              
            }
            .frame(height: diameter)
            .animation(.easeInOut(duration: 0.4), value: load)

            HStack(spacing: 10) {
                ForEach(Array(text.prefix(total).enumerated()), id: \.offset) { _, label in
                    Text(label)
                        .font(.system(size: 13))
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}
#Preview {
    ComponentLoad(load: 1, diameter: 10)
}
