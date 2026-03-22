//
//  CheckListView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 21/03/26.
//

import SwiftUI

struct CheckListView: View {
    
    let doFirst = Array(TaskDataModel.dummyTasks[0...2])
    
    let scheduled = Array(TaskDataModel.dummyTasks[3...4])
    
    let delegated = Array(TaskDataModel.dummyTasks[5...6])
    
    let eliminate = Array(TaskDataModel.dummyTasks[7...8])
    
    
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
                    Button(action: {}) {
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
                        EisenhowerSectionView(tasks:doFirst, title: "Do First", icon:"bolt",fgColor: Color(hex: "#28C76F"))
                        EisenhowerSectionView(tasks:scheduled, title: "Schedule",icon:"calendar.badge.clock",fgColor: Color(hex: "#2563EB"))
                        EisenhowerSectionView(tasks:delegated, title: "Delegate",icon:"person.2",fgColor: Color(hex: "#D97706"))
                        EisenhowerSectionView(tasks:delegated, title: "Eliminate",icon:"xmark.circle",fgColor: Color(hex: "#6B7280"))
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
            }
    }
}

#Preview {
    CheckListView()
}
