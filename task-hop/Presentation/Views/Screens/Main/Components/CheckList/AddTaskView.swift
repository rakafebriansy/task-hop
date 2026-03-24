//
//  AddTaskView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var dueDate: Date = Date()
    @State private var selectedQuadrant: Priority = .doFirst
    
    @State private var isAlarmEnabled: Bool = false
    
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
                        InputFieldView(title: "Due Date", icon: "calendar") {
                            HStack (spacing: 10) {
                                Text("Today")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color(hex: "#15803D"))
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundStyle(.gray)
                                
                            }
                            
                        }
                        InputFieldView(title: "Alarm", icon: "bell") {
                            Toggle("label is hidden", isOn: $isAlarmEnabled)
                                .labelsHidden()
                                .tint(Color(hex: "#15803D"))
                        }
                        InputFieldView(title: "Add Photo", icon: "photo") {
                            Button(action: {
                                //TODO: add photo handler
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .padding()
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(.black)
                                    .background(Color(hex: "#E5E7EB"))
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                            }
                        }
                        InputFieldView(title: "Add Document", icon: "text.document") {
                            Button(action: {
                                //TODO: add doc handler
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .padding()
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(.black)
                                    .background(Color(hex: "#E5E7EB"))
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
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
