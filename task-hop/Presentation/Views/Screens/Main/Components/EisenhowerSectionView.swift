//
//  EisenhowerSectionView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

import SwiftUI

struct EisenhowerSectionView: View {
    let tasks: [TaskDataModel]
    let title: String
    let icon: String
    let fgColor: Color
    
    var body: some View {
        VStack (spacing: 12) {
            HStack{
                HStack (alignment: .center){
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(fgColor)
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundStyle(fgColor)
                }
                Spacer()
                Text("\(tasks.count)")
                    .font(.subheadline.bold())
                    .padding(6)
                    .frame(width: 26, height: 26)
                    .foregroundStyle(fgColor)
                    .background(fgColor.opacity(0.1))
                    .clipShape(Circle())
            }
            VStack (spacing: 14) {
                ForEach(tasks) {
                    task in
                    HStack{
                        CheckboxView(task: task, icon: icon, fgColor: fgColor)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    EisenhowerSectionView(tasks: TaskDataModel.dummyTasks, title: "Do First", icon: "calendar.badge.clock", fgColor: Color(hex: "#DC2626"))
}
