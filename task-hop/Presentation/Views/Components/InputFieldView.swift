//
//  InputFieldView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

import SwiftUI

struct InputFieldView<TitleContent:View, ActionContent:View>: View {
    let icon: String
    let titleView: TitleContent
    let actionView: ActionContent
    
    init(icon: String, @ViewBuilder title: () -> TitleContent, @ViewBuilder actionView: () -> ActionContent) {
        self.icon = icon
        self.titleView = title()
        self.actionView = actionView()
    }
    
    var body: some View {
        HStack {
            HStack (spacing: 14) {
                Image(systemName: self.icon)
                    .padding(8)
                    .foregroundStyle(.black)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                titleView
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            
            actionView
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#F3F4F6"))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

extension InputFieldView where TitleContent == Text {
    init(title: String, icon: String, @ViewBuilder actionView: () -> ActionContent) {
        self.icon = icon
        self.actionView = actionView()
        
        self.titleView = Text(title)
            .fontWeight(.semibold)
            .foregroundStyle(.black)
    }
}

#Preview {
    InputFieldView(icon: "calendar", title: {
        Text("Due Date")
    }) {
        HStack (spacing: 10) {
            Text("Today")
                .fontWeight(.semibold)
                .foregroundStyle(Color(hex: "#15803D"))
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.gray)
            
        }
    }
}
