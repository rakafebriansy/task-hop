//
//  ProfileView.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

import SwiftUI

struct ProfileView: View {
    @State private var isLoggedIn: Bool = false
    @State private var username: String = "Dummy Example"
    @State private var email: String = "dummy@example.com"
    @State private var isNotifOn: Bool = true
    @State private var isDarkMode: Bool = false
    @State private var selectedLanguage: String = "English"
    
    let languages = ["English", "Indonesia", "Filipino"]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        if isLoggedIn {
                            Text(username)
                                .font(.title3.bold())
                            Text(email)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        } else {
                            Text("Not logged in")
                                .font(.title3.bold())
                                .foregroundStyle(.secondary)
                            Text("Please to sync your tasks.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            Button(action:  {
                                withAnimation {
                                    isLoggedIn = true
                                }
                            }) {
                                HStack {
                                    Image(systemName: "g.circle.fill")
                                    Text("Continue with Google")
                                }
                                .font(.callout.bold())
                                .foregroundStyle(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 14)
                                .background(.blue)
                                .clipShape(Capsule())
                                .padding(.top, 4)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 4)
                }
                Section(header: Text("Preferences")) {
                    Toggle(isOn: $isNotifOn) {
                        Label("Notification", systemImage: "bell.badge.fill")
                            .foregroundStyle(isNotifOn ? .blue : .primary)
                    }
                    Toggle(isOn: $isDarkMode) {
                        Label("Dark Mode", systemImage: "moon.fill")
                            .foregroundStyle(isNotifOn ? .indigo : .primary)
                    }
                    Picker(selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { lang in
                            Text(lang).tag(lang)
                        }
                    } label: {
                        Label("Language", systemImage: "globe")
                    }
                }
                Section(header: Text("Others")) {
                    NavigationLink(destination: Text("Help & Support")) {
                        Label("Help & Support", systemImage: "questionmark.circle")
                    }
                    
                    NavigationLink(destination: Text("Privacy Policy")) {
                        Label("Privacy Policy", systemImage: "hand.raised.fill")
                    }
                    
                    if isLoggedIn {
                        Button(action: {
                            withAnimation { isLoggedIn = false }
                        }) {
                            Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
        }
        .navigationTitle("Profile")
        .listStyle(.insetGrouped)
    }
}

#Preview {
    ProfileView()
}
