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
    case subject_topics(SubjectType)
    case subject_topics_detail(Topic)
    case slide_views(Topic)
    case ar
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
