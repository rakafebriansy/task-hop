//
//  TaskEntity.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import Foundation

struct TaskEntity: Identifiable {
    let id: UUID
    var title: String
    var dueDate: Date?
    var isUrgent: Bool
    var isImportant: Bool
    var isCompleted: Bool
    var isAlarmEnabled: Bool
    var photoData: Data?
    var documentData: Data?
    var documentFilename: String?
    var createdAt: Date
    
    var subTasks: [TaskEntity]
    var parentId: UUID?
    
    var matrixCategory: String {
        if isUrgent && isImportant {
            return "Do First"
        }
        if !isUrgent && isImportant {
            return "Schedule"
        }
        if isUrgent && !isImportant {
            return "Delegate"
        }
        return "Elimiate"
    }
}
