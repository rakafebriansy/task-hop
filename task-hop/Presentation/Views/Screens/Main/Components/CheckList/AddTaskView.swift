//
//  AddTaskView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

import SwiftUI
import SwiftData
import PhotosUI
import UniformTypeIdentifiers

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    
    @Query private var existingTasks: [TaskDataModel]
    
    @State private var title: String = ""
    @State private var dueDate: Date = Date()
    @State private var selectedQuadrant: Priority = .doFirst
    @State private var isAlarmEnabled: Bool = false
    @State private var selectedParent: TaskDataModel? = nil
    
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var selectedPhotoData: Data? = nil
    @State private var photoFilename: String?
    
    @State private var showDocumentPicker: Bool = false
    @State private var selectedDocumentURL: URL? = nil
    @State private var documentFilename: String? = nil
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    TextField("e.g., Buy coffee tomorrow at 9 AM", text: $title)
                        .font(.system(size: 26, weight: .bold))
                        .textFieldStyle(.plain)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("PRIORITY & URGENCY")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(hex: "#6B7280"))
                        QuadrantSelectorView(selectedQuadrant: $selectedQuadrant)
                    }
                    VStack (spacing:10) {
                        
                        InputDropdownView(
                            title: "Subtask of",
                            icon: "folder",
                            selectedText: selectedParent?.title ?? "None (Standalone)"
                        ) {
                            Button("None (Standalone)") {
                                selectedParent = nil
                            }
                            Divider()
                            ForEach(existingTasks) { task in
                                Button(task.title) {
                                    selectedParent = task
                                }
                            }
                        }
                        InputFieldView(title: "Due Date", icon: "calendar") {
                            DatePicker("", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                                .labelsHidden()
                        }
                        InputFieldView(title: "Alarm", icon: "bell") {
                            Toggle("label is hidden", isOn: $isAlarmEnabled)
                                .labelsHidden()
                                .tint(Color(hex: "#15803D"))
                        }
                        InputFieldView(icon: "photo", title: {
                            if let filename = photoFilename {
                                Text(filename)
                                    .italic()
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.gray)
                            } else {
                                Text("Add Image")
                                    .fontWeight(.semibold)
                            }
                        }) {
                            HStack(alignment: .center, spacing: 16) {
                                PhotosPicker(selection: $selectedPhotoItem, matching: .images, photoLibrary: .shared()) {
                                    if let selectedPhotoData, let uiImage = UIImage(data: selectedPhotoData) {
                                        ZStack {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 44, height: 44)
                                                .clipShape(RoundedRectangle(cornerRadius: 14))
                                            Image(systemName: "pencil")
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundStyle(.black)
                                                .padding(4)
                                                .background(.white.opacity(0.7))
                                                .clipShape(Circle())
                                        }
                                    } else {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .padding()
                                            .frame(width: 44, height: 44)
                                            .foregroundStyle(.black)
                                            .background(Color(hex: "#E5E7EB"))
                                            .clipShape(RoundedRectangle(cornerRadius: 14))
                                    }
                                }
                                .onChange(of: selectedPhotoItem) {
                                    oldValue, newValue in
                                    Task {
                                        guard let item = newValue else {
                                            selectedPhotoData = nil
                                            photoFilename = nil
                                            return
                                        }
                                        
                                        do {
                                            if let data = try await item.loadTransferable(type: Data.self) {
                                                withAnimation {
                                                    selectedPhotoData = data
                                                    photoFilename = "Image Attached"
                                                }
                                            } else {
                                                toastMessage = "Format not supported."
                                                withAnimation(.spring()) {
                                                    showToast = true
                                                }
                                            }
                                        } catch {
                                            print("Failed to load image: \(error.localizedDescription)")
                                            toastMessage = "Failed to load image."
                                            withAnimation(.spring()) {
                                                showToast = true
                                            }
                                        }
                                    }
                                }
                                
                                if selectedPhotoData != nil {
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0.15)) {
                                            selectedPhotoData = nil
                                            selectedPhotoItem = nil
                                        }
                                    }) {
                                        Image(systemName: "xmark")
                                            .foregroundStyle(.black)
                                    }
                                }
                            }
                        }
                        InputFieldView(icon: "text.document", title: {
                            if let filename = documentFilename {
                                Text(filename)
                                    .italic()
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.gray)
                            } else {
                                Text("Add Document")
                                    .fontWeight(.semibold)
                            }
                        }) {
                            HStack(alignment: .center, spacing: 16) {
                                Button(action: {
                                    showDocumentPicker = true
                                }) {
                                    if selectedDocumentURL != nil {
                                        ZStack {
                                            Image(systemName: "doc.text.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .padding(10)
                                                .frame(width: 44, height: 44)
                                                .foregroundStyle(.white)
                                                .background(Color.blue)
                                                .clipShape(RoundedRectangle(cornerRadius: 14))
                                                .shadow(color: Color.black.opacity(0.1), radius: 3)
                                            Image(systemName: "pencil")
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundStyle(.white)
                                                .padding(6)
                                                .background(Color.black.opacity(0.5))
                                                .clipShape(Circle())
                                        }
                                    } else {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .padding()
                                            .frame(width: 44, height: 44)
                                            .foregroundStyle(.black)
                                            .background(Color(hex: "#E5E7EB"))
                                            .clipShape(RoundedRectangle(cornerRadius: 14))
                                    }
                                }
                                .fileImporter(isPresented: $showDocumentPicker, allowedContentTypes: [.pdf, .plainText, .text, .rtf, .data], allowsMultipleSelection: false) {
                                    result in
                                    switch result {
                                    case .success(let urls):
                                        if let url = urls.first {
                                            let filename = url.lastPathComponent
                                            withAnimation {
                                                selectedDocumentURL = url
                                                documentFilename = filename
                                            }
                                        }
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                        toastMessage = "Failed to load document."
                                        withAnimation(.spring()) {
                                            showToast = true
                                        }
                                    }
                                }
                                if selectedDocumentURL != nil {
                                    Button(action: {
                                        withAnimation(.spring()) {
                                            selectedDocumentURL = nil
                                            documentFilename = nil
                                        }
                                    }) {
                                        Image(systemName: "xmark")
                                            .foregroundStyle(.black)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(Color(hex: "#6B7280"))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        // TODO: Save task into swiftdata
                        dismiss()
                    }
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: "#15803D"))
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddTaskView()
}
