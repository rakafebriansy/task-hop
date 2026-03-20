//
//  CustomErrorDialog.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import Foundation
import SwiftUI

struct CustomErrorDialog: View {
    let error: AppError
    let onDismiss: () -> Void
    
    var body: some View {
        VStack (spacing: 0) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundStyle(.orange)
                .padding(.top, 12)
                .padding(.bottom, 24)
            Text(error.title)
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.bottom, 4)
            Text(error.message)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.bottom, 24)
            Button(action: onDismiss) {
                Text("OK")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                        .stroke(.blue, lineWidth: 1)
                    )
            }
            .padding(.bottom, 8)
            Text("v1.0.0")
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .padding(
            EdgeInsets(top: 24, leading: 32, bottom: 24, trailing: 32)
        )
        .background(Color(uiColor: UIColor.systemBackground))
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 32)
    }
}

struct ErrorDialogModifier: ViewModifier {
    @Binding var error: AppError?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if let currentError = error {
                Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    error = nil
                }
                
                CustomErrorDialog(error: currentError) {
                    error = nil
                }
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: error != nil)
    }
}

extension View {
    func withErrorDialog(error: Binding<AppError?>) -> some View {
        self.modifier(ErrorDialogModifier(error: error))
    }
}
