//
//  AuthRepositoryProtocol.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import Foundation

protocol AuthRepositoryProtocol {
    func signIn() async throws -> ProfileEntity
    func signOut()
    func getCurrentUser() async throws -> ProfileEntity?
}
