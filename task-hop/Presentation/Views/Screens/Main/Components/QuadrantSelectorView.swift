//
//  QuadrantSelectorView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

import SwiftUI

struct QuadrantSelectorView: View {
    
    @Binding var selectedQuadrant: Priority
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]
    
    let quadrants = [
        (title: Priority.doFirst, description: "Critical tasks to complete immediately", icon: "bolt", color: Color(hex: "#DC2626")),
        (title: Priority.schedule, description: "Important goals for long-term success", icon: "alarm", color: Color(hex: "#2563EB")),
        (title: Priority.delegate, description:"Tasks to assign to someone else", icon: "person.2", color: Color(hex: "#D97706")),
        (title: Priority.eliminate, description: "Distractions to reduce or remove", icon: "trash", color: Color(hex: "#6B7280")),
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(quadrants, id: \.title) {
                quadrant in
                let isSelected = selectedQuadrant == quadrant.title
                
                Button(action: {
                    withAnimation(.spring(response: 0.1, dampingFraction: 0.7)) {
                        selectedQuadrant = quadrant.title
                    }
                    
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                }) {
                    Color.clear
                        .aspectRatio(4/3, contentMode: .fill)
                    
                        .overlay(alignment: .topLeading) {
                            VStack(alignment: .leading, spacing: 8) {
                                Image(systemName: isSelected ? "\(quadrant.icon).fill" : quadrant.icon)
                                    .font(.system(size: 24))
                                    .foregroundStyle(isSelected ? .white : quadrant.color)
                                    .padding(.bottom, 2)
                                
                                Text(quadrant.title.name)
                                    .font(.headline)
                                    .fontWeight(isSelected ? .bold : .medium)
                                    .foregroundStyle(isSelected ? .white : Color(hex: "#374151"))
                                
                                Text(quadrant.description)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(isSelected ? .white.opacity(0.8) : quadrant.color.opacity(0.7))
                                    .multilineTextAlignment(.leading)
                            }
                            .padding(16)
                        }
                    
                        .background(isSelected ? quadrant.color : quadrant.color.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(isSelected ? quadrant.color : quadrant.color.opacity(0.3), lineWidth: 2.5)
                        )
                        .shadow(color: isSelected ? quadrant.color.opacity(0.4) : .clear, radius: 8, x: 0, y: 4)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    QuadrantSelectorView(selectedQuadrant: .constant(Priority.doFirst))
        .padding()
}
