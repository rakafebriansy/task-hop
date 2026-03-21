//
//  SolidBlobShape.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 21/03/26.
//

import SwiftUI

struct SolidBlobShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: 0.15 * width, y: 0.55 * height))
        path.addCurve(to: CGPoint(x: 0.25 * width, y: 0.90 * height),
                      control1: CGPoint(x: 0.10 * width, y: 0.70 * height),
                      control2: CGPoint(x: 0.15 * width, y: 0.85 * height))
        path.addCurve(to: CGPoint(x: 0.75 * width, y: 0.85 * height),
                      control1: CGPoint(x: 0.40 * width, y: 1.00 * height),
                      control2: CGPoint(x: 0.60 * width, y: 0.90 * height))
        path.addCurve(to: CGPoint(x: 0.90 * width, y: 0.50 * height),
                      control1: CGPoint(x: 0.95 * width, y: 0.75 * height),
                      control2: CGPoint(x: 1.00 * width, y: 0.60 * height))
        path.addCurve(to: CGPoint(x: 0.70 * width, y: 0.15 * height),
                      control1: CGPoint(x: 0.90 * width, y: 0.35 * height),
                      control2: CGPoint(x: 0.80 * width, y: 0.20 * height))
        path.addCurve(to: CGPoint(x: 0.30 * width, y: 0.25 * height),
                      control1: CGPoint(x: 0.60 * width, y: 0.10 * height),
                      control2: CGPoint(x: 0.45 * width, y: 0.15 * height))
        path.addCurve(to: CGPoint(x: 0.15 * width, y: 0.55 * height),
                      control1: CGPoint(x: 0.20 * width, y: 0.30 * height),
                      control2: CGPoint(x: 0.15 * width, y: 0.45 * height))
        path.closeSubpath()
        return path
    }
}
