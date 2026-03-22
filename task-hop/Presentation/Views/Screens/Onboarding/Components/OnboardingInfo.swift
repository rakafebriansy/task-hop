//
//  OnboardingItem.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 21/03/26.
//

import SwiftUI
import Foundation

struct  OnboardingProps: Identifiable {
    let id: UUID = UUID()
    let title: String
    let description: String
    let image: String
    let gradientColors: [Color]
}
