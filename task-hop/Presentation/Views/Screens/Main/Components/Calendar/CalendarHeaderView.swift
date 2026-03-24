//
//  CalendarHeaderView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

import SwiftUI

struct CalendarHeaderView: View {
    @Binding var currentDate: Date
    
    private var monthAndYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentDate)
    }
    
    var body: some View {
        HStack {
            HStack (spacing: 20) {
                Button(action: {
                    withAnimation {
                        currentDate = currentDate.monthBefore
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(Color(hex: "#374151"))
                }
                Text(monthAndYear)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                Button(action: {
                    withAnimation {
                        currentDate = currentDate.monthAfter
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(Color(hex: "#374151"))
                }
            }
            Spacer()
            Button(action: {
                //TODO: open search field
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color(hex: "#374151"))
                    .padding(10)
                    .background(Circle().fill(Color.gray.opacity(0.1)))
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 10)
    }
}

//#Preview {
//    CalendarHeaderView()
//}
