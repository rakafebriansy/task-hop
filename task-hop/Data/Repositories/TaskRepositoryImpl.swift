//
//  TaskRepositoryImpl.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import Foundation
import SwiftData

class TaskRepositoryImpl: TaskRepositoryProtocol {
    private let modelContext: ModelContext
    
    init (modelContext: ModelContext){
        self.modelContext = modelContext
    }
    
    func fetchTasks() throws -> [TaskEntity] {
        let descriptor = FetchDescriptor<TaskDataModel>(
            predicate: #Predicate {$0.parentTask == nil},
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        let dataModels = try modelContext.fetch(descriptor)
        return dataModels.map { $0.toEntity() }
    }
    
    func addTask(_ task: TaskEntity) throws {
        let dataModel = task.toDataModel()
        modelContext.insert(dataModel)
        try modelContext.save()
    }
    
    func updateTask(_ task: TaskEntity) throws {
        let id = task.id
        let descriptor = FetchDescriptor<TaskDataModel>(predicate: #Predicate { $0.id == id })
        if let dataModel = try modelContext.fetch(descriptor).first {
            dataModel.title = task.title
            dataModel.isUrgent = task.isUrgent
            dataModel.isImportant = task.isImportant
            dataModel.isCompleted = task.isCompleted
            dataModel.dueDate = task.dueDate
            try modelContext.save()
        }
    }
    
    func deleteTask(id: UUID) throws {
        let descriptor = FetchDescriptor<TaskDataModel>(predicate: #Predicate { $0.id == id })
        if let dataModel = try modelContext.fetch(descriptor).first {
            modelContext.delete(dataModel)
            try modelContext.save()
        }
    }
}
