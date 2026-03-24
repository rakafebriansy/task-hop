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
    @State private var dragTranslation: CGFloat = 0
    
    let content: Content
    
    init(sheetState: Binding<SheetState>, @ViewBuilder content: () -> Content) {
        self._sheetState = sheetState
        self.content = content()
    }
    
    private var currentOffset: CGFloat {
        let collapsedOffset: CGFloat = screenHeight * 0.65
        let expandedOffset: CGFloat = screenHeight * 0.25
        
        let baseOffset: CGFloat = sheetState == .expanded ? expandedOffset : collapsedOffset
        let calculatedOffset: CGFloat = baseOffset + dragTranslation
        
        return min(max(calculatedOffset, expandedOffset), collapsedOffset)
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
                    .onChanged {
                        value in
                        dragTranslation = value.translation.height
                    }
                    .onEnded{
                        value in
                        withAnimation (.spring(response: 0.4, dampingFraction: 0.8)) {
                            if sheetState == .collapsed && value.translation.height < -50 {
                                sheetState = .expanded
                            } else if sheetState == .expanded && value.translation.height > 50 {
                                sheetState = .collapsed
                            }
                            
                            dragTranslation = 0
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
