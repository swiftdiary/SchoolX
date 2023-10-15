//
//  Progress.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import Foundation

struct Progress: Codable {
    var milestone: Milestone
    var badges: [Badge]
    
    enum CodingKeys: String, CodingKey {
        case milestone = "milestone"
        case badges = "badges"
    }
}

struct Milestone: Codable {
    var history: [History] = []
    var estimatedCount: Int
    
    enum CodingKeys: String, CodingKey {
        case history = "history"
        case estimatedCount = "estimated_count"
    }
    
    struct History: Codable, Identifiable, Equatable {
        var id: UUID { UUID() }
        let date: Date
        let topics: [String]
        var spentTime: Int
        
        enum CodingKeys: String, CodingKey {
            case date = "date"
            case topics = "topics"
            case spentTime = "spent_time"
        }
    }
}

struct Badge: Codable {
    let name: String
    let lottie: String
    let skill: Topic
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case lottie = "lottie"
        case skill = "skill"
    }
}
