//
//  Subject.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum SubjectType: String, Identifiable, Codable {
    var id: String { UUID().uuidString }
    var imageUrl: String {
        switch self {
        case .astronomy:
            return "https://images.pexels.com/photos/1169754/pexels-photo-1169754.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
        case .physics:
            return "https://images.unsplash.com/photo-1635070041409-e63e783ce3c1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2758&q=80"
        case .chemistry:
            return "https://img.freepik.com/premium-photo/science-background-design_974729-4517.jpg"
        case .biology:
            return "https://i.pinimg.com/originals/6d/1c/aa/6d1caafa036d5f3db0ba6e8c52176b29.jpg"
        case .it:
            return "https://images.unsplash.com/photo-1619410283995-43d9134e7656?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHByb2dyYW1taW5nfGVufDB8fDB8fHww&w=1000&q=80"
        }
    }
    
    case astronomy
    case physics
    case chemistry
    case biology
    case it
    
    static var allCases: [Self] {
        [.astronomy, .physics, .chemistry, .biology, .it]
    }
}

struct Slide: Codable, Hashable {
    let imageUrl: String
    let title: String
    let description: String
    // 3d Model
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case title = "title"
        case description = "description"
    }
}

struct Topic: Identifiable, Codable, Equatable, Hashable {
    static func == (lhs: Topic, rhs: Topic) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: UUID { UUID() }
    let topicId: String
    var subject: SubjectType?
    let name: String
    let description: String
    let imageUrl: String?
    var slides: [Slide?]?
    // 3d Model
    
    enum CodingKeys: String, CodingKey {
        case topicId = "topic_id"
        case subject = "subject"
        case name = "name"
        case description = "description"
        case imageUrl = "image_url"
        case slides = "slides"
    }
}

final class TopicManager {
    static let shared = TopicManager()
    private init() { }
    
    private let topicCollection: CollectionReference = Firestore.firestore().collection("topics")
    
    private func topicDocument(topicId: String) -> DocumentReference {
        topicCollection.document(topicId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()

    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func createNewTopic(topic: Topic) async throws {
        try topicDocument(topicId: topic.topicId).setData(from: topic, merge: false)
    }
    
    func getTopic(topicId: String) async throws -> Topic {
        try await topicDocument(topicId: topicId).getDocument(as: Topic.self)
    }
    
    func getAllTopics() async throws -> [Topic] {
        let documents = try await topicCollection.getDocuments().documents
        return try documents.map { snapshot in
            try snapshot.data(as: Topic.self)
        }
    }
    
    private func getTopicsQuery(subject: SubjectType) -> Query {
        topicCollection
            .whereField(Topic.CodingKeys.subject.rawValue, isEqualTo: subject.rawValue)
    }
    
    func getTopicsFiltered(by subject: SubjectType) async throws -> [Topic] {
        let query = getTopicsQuery(subject: subject)
        let snapshot = try await query.getDocuments()
        return try snapshot.documents.map { snap in
            try snap.data(as: Topic.self)
        }
    }
}
