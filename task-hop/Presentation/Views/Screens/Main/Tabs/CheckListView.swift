//
//  CheckListView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 21/03/26.
//

import SwiftUI
import SwiftData

struct CheckListView: View {
    
    @Query(sort: \TaskDataModel.createdAt, order: .reverse) private var allTasks: [TaskDataModel]
    
    @State private var isShowAddTaskForm = false
    
    private var doFirstTasks: [TaskDataModel] {
        allTasks.filter {
            $0.isUrgent && $0.isImportant
        }
    }
    private var scheduleTasks: [TaskDataModel] {
        allTasks.filter {
            !$0.isUrgent && $0.isImportant
        }
    }
    private var delegateTasks: [TaskDataModel] {
        allTasks.filter {
            $0.isUrgent && !$0.isImportant
        }
    }
    private var eliminateTasks: [TaskDataModel] {
        allTasks.filter {
            !$0.isUrgent && !$0.isImportant
        }
    }
    
    var body: some View {
            VStack(spacing: 0) {
                HStack {
                    HStack (spacing: 6) {
                        Image("icPepe")
                            .resizable()
                            .padding(4)
                            .frame(width: 24, height: 24)
                            .background(.white)
                            .clipShape(Circle())
                        Text("14")
                            .font(.footnote.bold())
                            .foregroundStyle(Color(hex:"#044E8C"))
                        Image(systemName: "flame.fill")
                            .resizable()
                            .frame(width: 14, height: 16)
                            .foregroundStyle(.orange)
                    }
                    .padding(8)
                    .background(Color(hex: "#E6F7FF"))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    Spacer()
                    Button(action: {
                        isShowAddTaskForm = true
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.white)
                            .background(Color(hex: "#28C76F"))
                            .clipShape(Circle())
                    }
                }
                .overlay(
                    Text("Tasks")
                        .font(.title3.bold())
                )
                .padding(.horizontal,16 )
                .padding(.bottom, 20)
                
                ScrollView {
                    VStack (spacing: 20) {
                        EisenhowerSectionView(tasks:doFirstTasks, title: "Do First", icon:"bolt",fgColor: Color(hex: "#28C76F"))
                        EisenhowerSectionView(tasks:scheduleTasks, title: "Schedule",icon:"calendar.badge.clock",fgColor: Color(hex: "#2563EB"))
                        EisenhowerSectionView(tasks:delegateTasks, title: "Delegate",icon:"person.2",fgColor: Color(hex: "#D97706"))
                        EisenhowerSectionView(tasks:eliminateTasks, title: "Eliminate",icon:"xmark.circle",fgColor: Color(hex: "#6B7280"))
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
            }
            .sheet(isPresented: $isShowAddTaskForm) {
                AddTaskView()
                    .presentationDetents([.large])
                    .presentationCornerRadius(24)
            }
    }
}

#Preview {
    CheckListView()
}
