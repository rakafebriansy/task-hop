//
//  MinimalToggleView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

import SwiftUI

struct MinimalToggleView: View {
    @State private var isOn = false
    var body: some View {
        ZStack(alignment: isOn ? .trailing : .leading) {
            
            Capsule()
                .fill(isOn ? Color(hex: "#15803D") : Color(hex: "#E5E7EB"))
                .frame(width: 50, height: 28)
            
           
            Circle()
                .fill(.white)
                .padding(3)
                .shadow(radius: 1, x: 0, y: 1)
        }
        .frame(width: 50, height: 28)
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                isOn.toggle()
            }
        }
    }
}

#Preview {
    MinimalToggleView()
}
