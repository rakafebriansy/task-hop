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
    let firstDayOfWeek: Int = 2
    private let defaultWeekdays = ["S", "M", "T", "W", "T", "F", "S"]
    
    private var weekdays: [String] {
        let index = firstDayOfWeek - 1
        let start = Array(defaultWeekdays[index...])
        let end = Array(defaultWeekdays[0..<index])
        return start + end
    }
    private var daysInMonth: [Date?] {
        var calendar = Calendar.current
        calendar.firstWeekday = firstDayOfWeek
        
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        guard let firstDayOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) else { return [] }
        
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
    
    private var localCalendar: Calendar {
        var cal = Calendar.current
        cal.firstWeekday = firstDayOfWeek
        return cal
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(0..<weekdays.count, id: \.self) { index in
                    Text(weekdays[index])
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                ForEach(0..<daysInMonth.count, id: \.self) {
                    index in
                    if let date = daysInMonth[index] {
                        DayView(date: date, isSelected: localCalendar.isDate(date, inSameDayAs: selectedDate), taskForDate: tasks.filter {
                            task in
                            if let safeDate = task.dueDate {
                                return localCalendar.isDate(safeDate, inSameDayAs: date)
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
