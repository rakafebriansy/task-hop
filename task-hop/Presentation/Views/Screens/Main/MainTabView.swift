//
//  MainTabView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    var body : some View {
        TabView {
            CheckListView()
                .tabItem {
                    Label("Home", systemImage: "checklist")
                }
            Text("Halaman Kalender")
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            ProfileView(authViewModel: authViewModel)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")                }
        }
        .tint(Color(hex: "#22C55E"))
    }
}

#Preview {
    MainTabView(authViewModel: AuthViewModel(authRepository: GoogleAuthRepositoryImpl()))
}
