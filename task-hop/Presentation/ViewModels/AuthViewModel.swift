//
//  AuthViewModel.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var appError: AppError? = nil
    @Published var currentUser: ProfileEntity?
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    func checkExistingSession() async {
        do {
            currentUser = try await authRepository.getCurrentUser()
        } catch {
            print("There's no active session.")
        }
    }
    
    func signIn() async {
        isLoading = true
        appError = nil
        
        do {
            currentUser = try await authRepository.signIn()
        } catch {
            appError = AppError(title: "Failed to Login", message: error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func signOut() async {
        authRepository.signOut()
        currentUser = nil
    }
}
