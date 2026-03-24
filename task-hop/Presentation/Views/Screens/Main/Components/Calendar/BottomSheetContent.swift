//
//  BottomSheetCalendarContent.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 23/03/26.
//

import SwiftUI

struct BottomSheetContent: View {
    let selectedDate: Date
    let tasks: [TaskDataModel]
    
    private var tasksForSelectedDate: [TaskDataModel] {
        let calendar = Calendar.current
        return tasks.filter {
            task in
            
            if let safeDate = task.dueDate {
                return calendar.isDate(safeDate, inSameDayAs: selectedDate)
            }
            
            return false
        }
    }
    
    private var dateAndTaskCount: String {
        let dateString = selectedDate.formatted(.dateTime.day().month(.wide))
        return "\(dateString), \(tasksForSelectedDate.count) Today's Tasks"
    }
    
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(dateAndTaskCount)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    //TODO: action more
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            List {
                ForEach(tasksForSelectedDate) {
                    task in
                    HStack(spacing: 15) {
                        Button(action: {
                            let impact = UIImpactFeedbackGenerator(style: .medium)
                            impact.impactOccurred()
                            
                            withAnimation {
                                task.isCompleted.toggle()
                            }
                        }) {
                            Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                                .font(.system(size: 24))
                                .foregroundStyle(task.isCompleted ? Color(hex: "#2563EB") : .gray)
                        }
                        .buttonStyle(.plain)
                        
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .font(.body)
                                .fontWeight(.medium)
                            Text(task.dueDate.map { Self.timeFormatter.string(from: $0) } ?? "No due date")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: task.iconName)
                            .font(.system(size: 20))
                            .foregroundStyle(task.color)
                    }
                    .padding(.vertical, 8)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }
}

//#Preview {
//    BottomSheetCalendarContent()
//}
