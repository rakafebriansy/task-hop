//
//  task_hopApp.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import SwiftUI
import GoogleSignIn

@main
struct task_hopApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL {
                    url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
