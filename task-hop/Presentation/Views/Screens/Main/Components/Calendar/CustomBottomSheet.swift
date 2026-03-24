//
//  CustomBottomSheet.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 23/03/26.
//

import SwiftUI

enum SheetState {
    case expanded
    case collapsed
}

struct CustomBottomSheet<Content: View>: View {
    @Binding var sheetState: SheetState
    @GestureState private var dragOffset: CGFloat = 0
    
    let content: Content
    
    init(sheetState: Binding<SheetState>, @ViewBuilder content: () -> Content) {
        self._sheetState = sheetState
        self.content = content()
    }
    
    private var currentOffset: CGFloat {
        let baseOffset: CGFloat = sheetState == .collapsed ? (screenHeight * 0.65) : (screenHeight * 0.25)
        let calculatedOffset = baseOffset + dragOffset
        return max(calculatedOffset, screenHeight * 0.15)
        
    }
    
    private let minHeight: CGFloat = screenHeight * 0.4
    private let maxHeight: CGFloat = screenHeight * 0.8
    
    var body: some View {
        GeometryReader {
            geometry in
            VStack {
                Capsule()
                    .frame(width: 40, height: 6)
                    .foregroundStyle(.secondary)
                    .padding(.top, 10)
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(.white)
            .clipShape(
                .rect(
                    topLeadingRadius: 30,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 30
                )
            )
            .shadow(radius: 5)
            .frame(height: screenHeight - currentOffset)
            .offset(y: currentOffset)
            .gesture(
                DragGesture()
                    .updating($dragOffset) {
                        value, state, _ in
                        state = value.translation.height
                    }
                    .onEnded{
                        value in
                        withAnimation {
                            if value.translation.height > 100 {
                                self.sheetState = .collapsed
                            } else if value.translation.height < -100 {
                                self.sheetState = .expanded
                            }
                        }
                    }
            )
        }
        .edgesIgnoringSafeArea(.all)
    }
}

//#Preview {
//    CustomBottomSheet(sheetState: .constant(.collapsed)) {
//        Text("Content")
//    }
//}
