//
//  ComponentLoad.swift
//  AppActivityPoc
//
//  Created by Pedro Monge Silveira on 29/10/26.
//
import SwiftUI

struct ComponentLoad: View {

    let load: Int
    var total: Int = 4
    var spacing: CGFloat = 6
    var diameter: CGFloat = 10
    var text: [String] = ["to lendo","preparando","ta quase", "chegou"]
    var body: some View {
        VStack{
            HStack(spacing: spacing) {
            ForEach(0..<total, id: \.self) { index in
                    let isActive = load > index
                    
                    Circle()
                        .fill(isActive ? .blue : Color.primary.opacity(0.2))
                        .frame(width: diameter, height: diameter)
                    
                    if (index < total - 1 ){
                        Capsule()
                            .fill(Color.primary.opacity(0.2))
                            .frame(height: 2)
                            .overlay(alignment: .leading) {
                                Capsule()
                                    .fill(.blue)
                                    .frame(width: load > index + 1 ? nil : 0)
                            }
                    }
                }
            }
            .animation(.easeInOut(duration: 0.4), value: load)
            
            HStack(spacing: 20){
            ForEach(text, id: \.self) { texto in
                    Text(texto)
                }
            }
        }
       
    }
}
#Preview {
    ComponentLoad(load: 1, diameter: 10)
}

