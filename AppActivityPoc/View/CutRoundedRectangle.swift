//
//  CutCornerRectangle.swift
//  AppActivityPoc
//
//  Created by João Duque Nardelli Wandermuren on 04/11/26.
//

import SwiftUI


/// Parte debaixo do componente de prato
struct CutRoundedRectangle: Shape {

    var cornerRadius: CGFloat = 26.0
    let height: CGFloat
    
    init(height: CGFloat, cornerRadius: CGFloat = 26.0) {
        self.height = min(max(height, 0), 1)
        self.cornerRadius = cornerRadius
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let fillHeight = rect.height * height
        let top = rect.maxY - fillHeight
        let radius = min(cornerRadius, min(rect.width, fillHeight) / 2)

        guard fillHeight > 0 else { return path }

        // Top-right rounded corner and right edge.
        path.move(to: CGPoint(x: rect.maxX, y: top))

        path.addLine(to: CGPoint(x: rect.minX, y: top))

        // Bottom-left and bottom-right rounded corners.
        path.addArc(
            center: CGPoint(x: rect.minX + radius, y: rect.maxY - radius),
            radius: radius,
            startAngle: .degrees(180),
            endAngle: .degrees(90),
            clockwise: true
        )
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.maxY))
        path.addArc(
            center: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius),
            radius: radius,
            startAngle: .degrees(90),
            endAngle: .degrees(0),
            clockwise: true
        )
        path.closeSubpath()
        return path
    }
}

#Preview {
    CutRoundedRectangle(height: 0.3)
        .frame(width: 200, height: 200)
}
