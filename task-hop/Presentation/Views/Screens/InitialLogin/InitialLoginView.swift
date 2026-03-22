//
//  SignInView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import SwiftUI
import Combine

public struct InitialLoginView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @Binding var hasFinishedInitialLogin: Bool
    
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
            .padding(.horizontal, 16)
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
                        
                        if(authViewModel.currentUser != nil) {
                            hasFinishedInitialLogin = true
                        }
                    }
                }) {
                    HStack{
                        Image("icGoogle")
                        Text("Continue with Google")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hex: "#111827"))
                        
                    }                                    }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 99))
                .padding(.top, 20)
                .shadow(color: Color(hex: "#22C55E").opacity(0.25), radius: 20, x: 0, y: 4)
                HStack {
                    VStack { Divider() }
                    Text("OR")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray.opacity(0.6))
                        .padding(.horizontal, 8)
                    VStack { Divider() }
                }.padding(.vertical, 4)
                Button(action: {
                    withAnimation (.easeInOut(duration: 0.5)){
                        hasFinishedInitialLogin = true
                    }
                }) {
                    Text("Maybe later, continue without signing in")
                        .font(.callout)
                        .foregroundStyle(.gray)
                        .underline()
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    InitialLoginView(authViewModel: AuthViewModel(authRepository: GoogleAuthRepositoryImpl()), hasFinishedInitialLogin: .constant(false))
}
