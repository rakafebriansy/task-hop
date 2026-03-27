//
//  task_hopApp.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 20/03/26.
//

import SwiftUI
import SwiftData
import GoogleSignIn

@main
struct task_hopApp: App {
    init() {
        print("App running...")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL {
                    url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear {
                    print("Content has been rendered")
                }
        }
        .modelContainer(for: TaskDataModel.self)
    }
}
