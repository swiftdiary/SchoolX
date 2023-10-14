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
    var id: UUID { UUID() }
    
    case astronomy
    case physics
    case chemistry
    case biology
    case it
    
    static var allCases: [Self] {
        [.astronomy, .physics, .chemistry, .biology, .it]
    }
}

struct Slide: Codable {
    let imageUrl: String
    let title: String
    let description: String
    // 3d Model
}

struct Topic: Identifiable, Codable {
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
        let snapshot = try await topicCollection.getDocuments()
        return try snapshot.documents.map { snap in
            try snap.data(as: Topic.self)
        }
    }
}
