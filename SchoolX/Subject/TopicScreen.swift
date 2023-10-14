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
    @State private var pressed: Bool = false
    
    var body: some View {
        List {
            ForEach(viewModel.topics) { topic in
                VStack {
                    HStack {
                        AsyncImage(url: URL(string: topic.imageUrl ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 210)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(15)
                        .overlay(alignment: .topTrailing) {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 45, height: 45)
                                .foregroundStyle(Color.white.opacity(0.7))
                                .overlay {
                                    Image(systemName: "heart\(pressed ? ".fill" : "")")
                                        .font(.largeTitle)
                                        .foregroundStyle(pressed ? Color.red : Color.black)
                                }
                                .onTapGesture {
                                    withAnimation(.bouncy(duration: 0.5)) {
                                        pressed.toggle()
                                    }
                                }
                                .padding(10)
                        }
                    }
                    
                    .frame(maxWidth: .infinity)
                    .frame(height: 230)
                    HStack {
                        Text("\(topic.name)")
                            .font(.title.bold())
                            .foregroundStyle(Color.accentColor)
                            .fontDesign(.rounded)
                        Spacer()
                        HStack {
//                            Text("See more")
//                                .font(.caption)
//                            .foregroundStyle(Color.secondary)
                            Image(systemName: "chevron.right")
                                .font(.title)
                                .foregroundStyle(Color.accentColor)
                                .fontWeight(.bold)
                            
                        }
                    }
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
        .listStyle(.plain)
        .navigationTitle("\(subjectType.rawValue.capitalized)")
        .navigationBarTitleDisplayMode(.large)
//        .scrollContentBackground(.hidden)
//        .background(
//            Image("backgroundImage")
//                .resizable()
//                .ignoresSafeArea()
//        )
    }
}

#Preview {
    NavigationStack {
        TopicScreen(subjectType: .astronomy)
    }
}
