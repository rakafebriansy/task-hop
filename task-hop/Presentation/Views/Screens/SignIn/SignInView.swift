//
//  SignInView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import SwiftUI
import Combine

public struct SignInView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    public var body: some View {
        VStack {
            VStack (spacing: 24) {
                Image("illPepeDraw")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
                    .background(.white)
                    .cornerRadius(40)
                    .shadow(color: Color(hex: "#22C55E").opacity(0.15), radius: 40, x: 0, y: 24)
                VStack {
                    Text("TaskHop").font(.title).fontWeight(.bold)
                    Text("Master Your Priorities. Level up your life. ").font(.headline).fontWeight(.semibold).foregroundStyle(Color(hex: "#6B7280"))
                }
                VStack(spacing: 12) {
                    FeatureCardView(title: "Prioritize effortlessly using the Eisenhower Matrix.", image: "square.grid.2x2", fgColorHex: "#DC2626", bgColorHex: "#FEE2E2")
                    FeatureCardView(title: "Prioritize effortlessly using the Eisenhower Matrix.", image: "bolt", fgColorHex: "#16A34A", bgColorHex: "#DCFCE7")
                    FeatureCardView(title: "Prioritize effortlessly using the Eisenhower Matrix.", image: "icloud.and.arrow.up", fgColorHex: "#2563EB", bgColorHex: "#DBEAFE")
                }
            }
            .padding(.horizontal, 24)
            Spacer()
            VStack (spacing: 16) {
                if let error = authViewModel.appError?.message {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button(action: {
                    Task {
                        await authViewModel.signIn()
                    }
                }) {
                    HStack{
                        Image("icGoogle")
                        Text("Continue with Google")
                            .foregroundColor(Color(hex: "#111827"))
                        
                    }                                    }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 99))
                .padding(.top, 20)
                .shadow(color: Color(hex: "#22C55E").opacity(0.25), radius: 20, x: 0, y: 8)
                Text("By continuing, you agree to TaskHop's Privacy Policy and Data Policy.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(hex: "#374151"))
                    .padding(.horizontal)
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    ContentView()
}
