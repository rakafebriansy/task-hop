//
//  CheckListView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 21/03/26.
//

import SwiftUI

struct CheckListView: View {
    var body: some View {
        VStack {
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
        }
        .padding(24)
    }
}

#Preview {
    CheckListView()
}
