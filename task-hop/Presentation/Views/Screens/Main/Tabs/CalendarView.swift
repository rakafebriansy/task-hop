//
//  CalendarView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentDate: Date = Date()
    @State private var selectedDate: Date = Date()
    @State private var sheetState: SheetState = .collapsed
    @State private var tasks: [TaskDataModel] = TaskDataModel.dummyTasks
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                CalendarHeaderView(currentDate: $currentDate)
                CalendarGridView(selectedDate: $selectedDate, currentDate: currentDate, tasks: tasks)
                Spacer()
            }
            .safeAreaPadding(.top)
            CustomBottomSheet(sheetState: $sheetState) {
                BottomSheetContent(selectedDate: selectedDate, tasks: tasks)
            }
        }
    }
}

#Preview {
    CalendarView()
}
