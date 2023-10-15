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
                TopicImageView(topic: topic, url: topic.imageUrl ?? "", key: topic.topicId)
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

struct TopicImageView: View {
    var topic: Topic
    @State private var pressed: Bool = false
    
    @StateObject private var imageCacher: ImageCacher
    
    init(topic: Topic, url: String, key: String) {
        self.topic = topic
        _imageCacher = StateObject(wrappedValue: ImageCacher(url: url, key: key))
    }
    
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    if imageCacher.isLoading {
                        ProgressView()
                            .frame(width: 300, height: 200, alignment: .center)
                    } else if let image = imageCacher.image  {
                        Image(uiImage: image)
                           .resizable()
                           .frame(height: 240)
                           .frame(maxWidth: .infinity)
                           .cornerRadius(15)
                           .ignoresSafeArea()
                   }
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
                .overlay(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(width: 100, height: 40)
                        .foregroundStyle(Color.white.opacity(0.4))
                        .overlay {
                            Text("\((topic.slides ?? []).count) pages")
                                .foregroundStyle(Color.white)
                        }
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
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .foregroundStyle(Color.accentColor)
                        .fontWeight(.bold)
                    
                }
            }
        }
    }
}
