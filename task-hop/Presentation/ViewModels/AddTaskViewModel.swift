//
//  AddTaskViewModel.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 25/03/26.
//

import Foundation
import SwiftData
import SwiftUI
import PhotosUI

class AddTaskViewModel {
    func saveTask(
        context: ModelContext,
        title: String,
        dueDate: Date,
        selectedQuadrant: Priority,
        isAlarmEnabled: Bool,
        selectedParent: TaskDataModel?,
        selectedPhotoData: Data?,
        documentFilename: String?,
        selectedDocumentURL: URL?
    ) throws {
        let isUrgent = (selectedQuadrant == .doFirst || selectedQuadrant == .delegate)
        let isImportant = (selectedQuadrant == .doFirst || selectedQuadrant == .schedule)
        
        var finalDocumentData: Data? = nil
        if let docURL = selectedDocumentURL {
            if docURL.startAccessingSecurityScopedResource() {
                defer {
                    docURL.stopAccessingSecurityScopedResource()
                }
                finalDocumentData = try Data(contentsOf: docURL)
            }
        }
        
        let newTask = TaskDataModel(
            title: title,
            dueDate: dueDate,
            isUrgent: isUrgent,
            isImportant: isImportant,
            isAlarmEnabled: isAlarmEnabled,
            photoData: selectedPhotoData,
            documentData: finalDocumentData,
            documentFilename: documentFilename
        )
        
        if let parent = selectedParent {
            newTask.parentTask = parent
            if parent.subTasks == nil {
                parent.subTasks = []
            }
            parent.subTasks?.append(newTask)
        }
        
        context.insert(newTask)
        
        try context.save()
    }
}
