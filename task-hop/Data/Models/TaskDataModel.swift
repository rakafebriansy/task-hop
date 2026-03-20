//
//  TaskDataModel.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import Foundation
import SwiftData

@Model
class TaskDataModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var dueDate: Date?
    var isUrgent: Bool
    var isImportant: Bool
    var isCompleted: Bool
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade, inverse: \TaskDataModel.parentTask)
    var subTasks: [TaskDataModel]? = []
    
    var parentTask: TaskDataModel?
    
    init(id: UUID = UUID(), title: String, dueDate: Date? = nil, isUrgent: Bool, isImportant: Bool, isCompleted: Bool = false, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.isUrgent = isUrgent
        self.isImportant = isImportant
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
    
    func toEntity() -> TaskEntity {
        let mappedSubTasks = subTasks?.map { $0.toEntity() } ?? []
        return TaskEntity(id: id, title: title, dueDate: dueDate, isUrgent: isUrgent, isImportant: isImportant, isCompleted: isCompleted, createdAt: createdAt,
                   subTasks: mappedSubTasks,
                   parentId: parentTask?.id
        )
    }
}

extension TaskEntity {
    func toDataModel() -> TaskDataModel {
       let dataModel = TaskDataModel(
            id: id,
            title: title,
            dueDate: dueDate,
            isUrgent: isUrgent,
            isImportant: isImportant,
            isCompleted: isCompleted,
            createdAt: createdAt,
        )
        
        let mappedSubTasks = subTasks.map {
            subTaskEntity in
            subTaskEntity.toDataModel()
        }
        
        dataModel.subTasks = mappedSubTasks
        
        return dataModel
    }
}
