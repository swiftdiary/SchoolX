//
//  TopicDetailScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import SwiftUI

struct TopicDetailScreen: View {
    let topic: Topic
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    TopicDetailScreen(topic: Topic(topicId: "", name: "", description: "", imageUrl: ""))
}
