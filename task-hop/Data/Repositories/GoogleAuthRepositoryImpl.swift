//
//  GoogleAuthRepositoryImpl.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import Foundation
import GoogleSignIn
import UIKit

class GoogleAuthRepositoryImpl: AuthRepositoryProtocol {
    @MainActor
    private func getRootViewController() -> UIViewController? {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let root = screen.windows.first(where: \.isKeyWindow)?.rootViewController else {
            return nil
        }
        return root
    }
    
    @MainActor
    func signIn() async throws -> ProfileEntity {
        guard let rootVC = getRootViewController() else {
            throw NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load main view"])
        }
        
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootVC)
        let user = result.user
        
        return ProfileEntity(
            id: user.userID ?? UUID().uuidString,
            name: user.profile?.name ?? "Unnamed",
            email: user.profile?.email ?? "No email",
            profileImageUrl: user.profile?.imageURL(withDimension: 200)
        )
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
    
    func getCurrentUser() async throws -> ProfileEntity? {
            guard GIDSignIn.sharedInstance.hasPreviousSignIn() else {
                return nil
            }
            
            do {
                try await GIDSignIn.sharedInstance.restorePreviousSignIn()
                
                guard let user = GIDSignIn.sharedInstance.currentUser else {
                    return nil
                }
                
                return ProfileEntity(
                    id: user.userID ?? UUID().uuidString,
                    name: user.profile?.name ?? "Unnamed",
                    email: user.profile?.email ?? "No email",
                    profileImageUrl: user.profile?.imageURL(withDimension: 200)
                )
            } catch {
                return nil
            }
        }
}
