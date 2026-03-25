//
//  CalendarGridView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

import SwiftUI

struct CalendarGridView: View {
    @Binding var selectedDate: Date
    
    let currentDate: Date
    let tasks: [TaskDataModel]
    
    private let calendar = Calendar.current
    private let weekdays = ["M", "T", "W", "T", "F", "S", "S"]
    private var daysInMonth: [Date?] {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        guard let firstDayOfMonth = calendar.date(from: components) else { return [] }
        
        guard let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) else { return [] }
        let totalDays = range.count
        
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        var offset = firstWeekday - calendar.firstWeekday
        if offset < 0 { offset += 7 }
        
        var days: [Date?] = Array(repeating: nil, count: offset)
        
        for day in 0..<totalDays {
            if let date = calendar.date(byAdding: .day, value: day, to: firstDayOfMonth) {
                days.append(date)
            }
        }
        
        return days
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(weekdays, id: \.self) {
                    day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.gray)
                }
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(0..<daysInMonth.count, id: \.self) {
                    index in
                    if let date = daysInMonth[index] {
                        DayView(date: date, isSelected: calendar.isDate(date, inSameDayAs: selectedDate), taskForDate: tasks.filter {
                            task in
                            if let safeDate = task.dueDate {
                                return calendar.isDate(safeDate, inSameDayAs: date)
                            }
                            return false
                        })
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                selectedDate = date
                            }
                        }
                    } else {
                        Color.clear
                            .frame(width: 30, height: 30)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CalendarGridView(selectedDate: .constant(Date()), currentDate: Date(), tasks: TaskDataModel.dummyTasks)
}
