
//
//  Untitled.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 21/03/26.
//

import SwiftUI

struct FeatureCardView: View {
    
    let title: String
    let image: String
    let fgColorHex: String
    let bgColorHex: String
    
    var body: some View {
        HStack (alignment: .center,spacing: 16) {
            Image(systemName: self.image)
                .resizable()
                .padding(.all, 10)
                .frame(width: 40, height: 40)
                .foregroundStyle(Color(hex: self.fgColorHex))
                .background(Color(hex: self.bgColorHex))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            
            Text(self.title)
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.semibold)
                .foregroundStyle(Color(hex: "#374151"))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke( .gray.opacity(0.2),lineWidth: 1)
        )
    }
}
