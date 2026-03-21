//
//  ProfileView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @AppStorage("hasFinishedInitialLogin") private var hasFinishedInitialLogin: Bool = false
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Ini Halaman Main Tab View (Beranda)")
                .font(.headline)
            Button(action: {
                hasSeenOnboarding = false
                hasFinishedInitialLogin = false
                Task {
                    await authViewModel.signOut()
                }
            }) {
                Text("DEV: Reset App & Logout")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
    }}

#Preview {
    ProfileView(authViewModel: AuthViewModel(authRepository: GoogleAuthRepositoryImpl()))
}
