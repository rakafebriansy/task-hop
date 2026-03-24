//
//  View+Extension.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 23/03/26.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(
            RoundedCornerShape(radius: radius, corners: corners)
        )
    }
}
