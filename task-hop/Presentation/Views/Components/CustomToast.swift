//
//  CustomToast.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 25/03/26.
//

import SwiftUI

struct CustomToast: View {
    let message: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
            Text(message)
                .font(.headline)
                .fontWeight(.medium)
        }
        .foregroundStyle(.white)
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
        .background(color)
        .clipShape(Capsule())
        .shadow(color: color.opacity(0.15), radius: 10, x: 0, y: 5)
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    
    let message: String
    let icon: String
    let color: Color
    let duration: TimeInterval
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    if isPresented {
                        VStack {
                            Spacer()
                            
                            CustomToast(message: message, icon: icon, color: color)
                                .padding(.bottom, 40)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                        withAnimation(.easeInOut) {
                                            isPresented = false
                                        }
                                    }
                                }
                        }
                        .zIndex(1)
                    }
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var showToast: Bool = false
        
        var body: some View {
            VStack(spacing: 20) {
                Image(systemName: "iphone")
                    .font(.system(size: 50))
                    .foregroundStyle(.gray)
                Text("Simulation")
                    .font(.headline)
                Button(action: {
                    withAnimation(.spring()) {
                        showToast = true
                    }
                }) {
                    Text("Test Toast")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toast(isPresented: $showToast, message: "Action successful!", icon: "checkmark.circle", color: .blue, duration: 4.0)
        }
    }
    
    return PreviewWrapper()
}
