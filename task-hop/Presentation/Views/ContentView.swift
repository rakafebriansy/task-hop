//
//  ContentView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel(authRepository: GoogleAuthRepositoryImpl())
    
    var body: some View {
        Group {
            if authViewModel.isLoading {
                ProgressView("Logging in...")
            } else if authViewModel.currentUser != nil {
                MainTabView()
            } else {
                SignInView(authViewModel: authViewModel)
            }
        }
        .task {
            await authViewModel.checkExistingSession()
        }
    }
}

//#Preview {
//    ContentView()
//}
