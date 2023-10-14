//
//  TabBarView.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject private var appNavigation: AppNavigation
    var body: some View {
        TabView(selection: $appNavigation.tab, content:  {
            HomeScreen()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(AppNavigationTab.home)
            SubjectScreen()
                .tabItem {
                    Label("Subjects", systemImage: "book.fill")
                }
                .tag(AppNavigationTab.subject)
            ProgressScreen()
                .tabItem {
                    Label("Progress", systemImage: "flame.fill")
                }
                .tag(AppNavigationTab.fire)
            ProfileScreen()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(AppNavigationTab.profile)
        })
    }
}

#Preview {
    TabBarView()
}
