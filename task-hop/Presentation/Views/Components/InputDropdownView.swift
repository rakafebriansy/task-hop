//
//  InputDropdownView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 25/03/26.
//

import SwiftUI

struct InputDropdownView<Content: View>: View {
    let title: String
    let icon: String
    
    let selectedText: String
    
    let options: Content
    
    init(title: String, icon: String, selectedText: String, @ViewBuilder options: () -> Content) {
        self.title = title
        self.icon = icon
        self.selectedText = selectedText
        self.options = options()
    }
    
    var body: some View {
        HStack{
            
            
            HStack(spacing: 14) {
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
            Menu {
                options
            } label: {
                HStack(spacing: 4) {
                    Text(selectedText)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .foregroundStyle(Color(hex: "#15803D"))
                    
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Color(hex: "#15803D"))
                }
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#F3F4F6"))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

//#Preview {
//    }
