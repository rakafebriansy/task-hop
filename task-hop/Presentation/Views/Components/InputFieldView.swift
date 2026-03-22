//
//  InputFieldView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

import SwiftUI

struct InputFieldView<Content:View>: View {
    let title: String
    let icon: String
    let actionView: Content
    
    init(title:String, icon: String, @ViewBuilder actionView: () -> Content) {
        self.title = title
        self.icon = icon
        self.actionView = actionView()
    }
    
    var body: some View {
        Button(action: {}) {
            HStack {
                HStack (spacing: 14) {
                    Image(systemName: self.icon)
                        .padding(8)
                        .foregroundStyle(.black)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    Text(self.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
                Spacer()
                actionView
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(Color(hex: "#F3F4F6"))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview {
    InputFieldView(title: "Due Date", icon: "calendar") {
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
