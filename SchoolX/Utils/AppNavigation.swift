//
//  AppNavigation.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 13/10/23.
//

import Foundation

enum AppNavigationPath {
    case signIn
    case signInWithEmail
    case home
}

final class AppNavigation: ObservableObject {
    @Published var path: [AppNavigationPath] = []
    
}
