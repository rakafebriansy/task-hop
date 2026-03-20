//
//  AppError.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import Foundation

struct AppError: Identifiable {
    let id = UUID()
    let title: String
    let message: String
}
