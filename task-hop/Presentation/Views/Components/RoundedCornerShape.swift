//
//  RoundedCornerShape.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 23/03/26.
//

import Foundation
import SwiftUI

struct RoundedCornerShape: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
