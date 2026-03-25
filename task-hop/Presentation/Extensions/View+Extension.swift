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
    
    func toast(isPresented: Binding<Bool>, message: String, icon: String = "info.circle", color: Color = .blue, duration: TimeInterval = 3.0) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, message: message, icon: icon, color: color, duration: duration))
    }
}
