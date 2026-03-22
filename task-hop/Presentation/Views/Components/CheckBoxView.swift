//
//  SwiftUIView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

import SwiftUI

struct CheckboxView: View {
    @State private var isChecked: Bool = false
    
    let task: TaskDataModel
    let icon: String
    let fgColor: Color
    
    var body: some View {
        HStack (alignment: .center, spacing: 12) {
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isChecked.toggle()
                }
                let impact = UIImpactFeedbackGenerator(style: .medium)
                impact.impactOccurred()
            }) {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundStyle(isChecked ? .green : .gray.opacity(0.5))
                    .frame(width: 32, height: 32)
            }
            .buttonStyle(.plain)
            
            Button(action: {
                //nav to detail
            }) {
                HStack {
                    VStack (alignment: .leading) {
                        Text(task.title)
                            .font(isChecked ? .body.italic() : .body)
                            .strikethrough(isChecked, color: .gray)
                            .foregroundStyle(isChecked ? .gray : .primary)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        HStack (alignment: .center){
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 14, height: 14)
                                .foregroundStyle(Color(hex: "#9CA3AF"))
                            if let date = task.dueDate {
                                Text("\(date.formatted(.relative(presentation: .named)).capitalized), \(date.formatted(.dateTime.hour().minute()))")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                    .foregroundStyle(Color(hex: "#9CA3AF"))
                            } else {
                                Text("No due date")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                    .foregroundStyle(Color(hex: "#9CA3AF"))
                            }
                            
                        }
                    }
                    Spacer()
                    HStack(spacing: 12) {
                        Image(systemName: icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(fgColor)
                            .opacity(isChecked ? 0.4 : 1.0)
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color(hex: "#D1D5DB"))
                    }
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CheckboxView(task: TaskDataModel.dummyTasks[1], icon: "bolt", fgColor: Color(hex:"#28C76F"))
}
