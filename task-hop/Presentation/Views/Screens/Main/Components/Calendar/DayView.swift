//
//  DayView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 23/03/26.
//

import SwiftUI

struct DayView: View {
    let date: Date
    let isSelected: Bool
    let taskForDate: [TaskDataModel]
    
    private let calendar: Calendar = .current
    private var dayFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "d"
            return formatter
        }
    
    var body: some View {
        VStack (spacing: 4) {
            Text(dayFormatter.string(from: date))
                .font(.body)
                .frame(width: 30, height: 30)
                .background(isSelected ? .green : .clear)
                .clipShape(Circle())
                .foregroundStyle(isSelected ? .white : .black)
            
            if !taskForDate.isEmpty {
                HStack(spacing: 2) {
                    ForEach(Array(taskForDate.prefix(3)), id: \.title) { task in
                        Circle()
                            .frame(width: 4, height: 4)
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
}

//#Preview {
//    DayView()
//}
