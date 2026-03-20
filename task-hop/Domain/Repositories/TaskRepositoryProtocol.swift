//
//  TaskRepositoryProtocol.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import Foundation

protocol TaskRepositoryProtocol {
    func fetchTasks() throws -> [TaskEntity]
    func addTask(_ task: TaskEntity) throws
    func updateTask(_ task: TaskEntity) throws
    func deleteTask(id: UUID) throws
}
