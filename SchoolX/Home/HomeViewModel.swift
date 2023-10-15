//
//  HomeViewModel.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 15/10/23.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var discoverTopics: [Topic] = []
    
    @MainActor
    func getTopics() async throws {
        discoverTopics = try await TopicManager.shared.getAllTopics()
    }
}
