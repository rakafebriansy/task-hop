//
//  ContentView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel(authRepository: GoogleAuthRepositoryImpl())
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @AppStorage("hasFinishedInitialLogin") private var hasFinishedInitialLogin: Bool = false
    
    var body: some View {
        Group {
            if authViewModel.isLoading {
                ProgressView("Preparing workspace...")
            } else if !hasSeenOnboarding {
                OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
            } else if
                authViewModel.currentUser == nil && !hasFinishedInitialLogin {
                InitialLoginView(authViewModel: authViewModel, hasFinishedInitialLogin: $hasFinishedInitialLogin)
            } else {
                MainTabView(authViewModel: authViewModel)
            }
        }
        .task {
            await authViewModel.checkExistingSession()
        }
    }
}

#Preview {
    ContentView()
}
