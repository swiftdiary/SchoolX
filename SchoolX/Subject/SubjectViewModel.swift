//
//  SubjectViewModel.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import Foundation

final class SubjectViewModel: ObservableObject {
    @Published var topics: [Topic] = []
    
    func getTopics() async throws {
        topics = try await TopicManager.shared.getAllTopics()
    }
    
}
