//
//  TopicScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import SwiftUI

struct TopicScreen: View {
    @StateObject private var viewModel: TopicViewModel = TopicViewModel()
    @EnvironmentObject private var appNavigation: AppNavigation
    let subjectType: SubjectType
    
    var body: some View {
        List {
            ForEach(viewModel.topics) { topic in
                HStack {
                    Text("NAME: \(topic.name)")
                }
                .onTapGesture {
                    appNavigation.path.append(.subject_topics_detail(topic))
                }
            }
        }
        .task(priority: .high, {
            do {
                try await viewModel.getTopics(with: subjectType)
            } catch {
                print(error)
            }
        })
        .listStyle(.grouped)
    }
}

#Preview {
    TopicScreen(subjectType: .astronomy)
}
