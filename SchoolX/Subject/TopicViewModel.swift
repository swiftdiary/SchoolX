//
//  TopicViewModel.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import Foundation

final class TopicViewModel: ObservableObject {
    @Published var topics: [Topic] = []
    
    @MainActor
    func getTopics(with subject: SubjectType) async throws {
        topics = try await TopicManager.shared.getTopicsFiltered(by: subject)
    }
}
