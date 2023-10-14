//
//  AppNavigation.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 13/10/23.
//

import Foundation

enum AppNavigationPath: Hashable {
    case signIn
    case signInWithEmail
    case home
    case profile_editName
}

enum AppNavigationTab: Hashable {
    case home
    case subject
    case fire
    case profile
}

final class AppNavigation: ObservableObject {
    @Published var path: [AppNavigationPath] = []
    @Published var tab: AppNavigationTab = .home
}
