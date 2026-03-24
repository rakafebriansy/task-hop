//
//  TaskDataModel.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class TaskDataModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var dueDate: Date?
    var isUrgent: Bool
    var isImportant: Bool
    var isCompleted: Bool
    var createdAt: Date
    var parentTask: TaskDataModel?
    
    @Relationship(deleteRule: .cascade, inverse: \TaskDataModel.parentTask)
    var subTasks: [TaskDataModel]? = []
    
    var color: Color {
        if isUrgent && isImportant {
            return Color(hex: "#28C76F") // Do First (Green)
        } else if !isUrgent && isImportant {
            return Color(hex: "#2563EB") // Schedule (Blue)
        } else if isUrgent && !isImportant {
            return Color(hex: "#D97706") // Delegate (Orange)
        } else {
            return Color(hex: "#6B7280") // Eliminate (Gray)
        }
    }
    
    var iconName: String {
        if isUrgent && isImportant {
            return "bolt.fill"
        } else if !isUrgent && isImportant {
            return "calendar"
        } else if isUrgent && !isImportant {
            return "person.2.fill"
        } else {
            return "trash.fill"
        }
    }
    
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
    
    static var dummyTasks: [TaskDataModel] {
            let now = Date()
            
            // 1. Urgent & Important (Do First)
            let task1 = TaskDataModel(title: "Finish SwiftUI Onboarding", dueDate: now.addingTimeInterval(96000), isUrgent: true, isImportant: true)
            let task2 = TaskDataModel(title: "Fix Google Sign-In Bug", isUrgent: true, isImportant: true)
            
            // 2. Not Urgent but Important (Schedule)
            let task3 = TaskDataModel(title: "Read Self-Learning Research Paper", dueDate: now.addingTimeInterval(86400 * 2), isUrgent: false, isImportant: true)
            let task4 = TaskDataModel(title: "Plan App Architecture for v2", isUrgent: false, isImportant: true)
            
            // 3. Urgent but Not Important (Delegate)
            let task5 = TaskDataModel(title: "Reply to Freelance Client Emails", isUrgent: true, isImportant: false)
            let task6 = TaskDataModel(title: "Update Project Documentation", dueDate: now.addingTimeInterval(7200), isUrgent: true, isImportant: false)
            
            // 4. Not Urgent & Not Important (Eliminate)
            let task7 = TaskDataModel(title: "Scroll Tech Twitter", isUrgent: false, isImportant: false, isCompleted: true)
            let task8 = TaskDataModel(title: "Organize Desktop Folders", isUrgent: false, isImportant: false)
            
            // 5. Task with Subtasks (Complex Task)
            let parentTask = TaskDataModel(title: "Setup SwiftData Persistence", isUrgent: true, isImportant: true)
            let sub1 = TaskDataModel(title: "Create TaskDataModel", isUrgent: true, isImportant: true, isCompleted: true)
            let sub2 = TaskDataModel(title: "Setup ModelContainer", isUrgent: true, isImportant: true)
            
            // Link subtasks
            sub1.parentTask = parentTask
            sub2.parentTask = parentTask
            parentTask.subTasks = [sub1, sub2]
            
            return [task1, task2, task3, task4, task5, task6, task7, task8, parentTask]
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
