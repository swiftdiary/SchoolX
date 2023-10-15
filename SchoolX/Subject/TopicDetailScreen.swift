//
//  TopicDetailScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import SwiftUI

struct TopicDetailScreen: View {
    let topic: Topic
    let readPage: Int = 3
    @EnvironmentObject private var appNavigation: AppNavigation
    
    var body: some View {
        VStack {
            TopicImageView2(topic: topic, url: topic.imageUrl ?? "", key: topic.topicId)
                .overlay(alignment: .topLeading) {
                    Button(action: {
                        _ = appNavigation.path.popLast()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color.accentColor)
                            .font(.title)
                            .bold()
                            .padding(10)
                            .background(
                                Color(UIColor.systemBackground)
                            )
                            .cornerRadius(10)
                            .padding(.horizontal)
                    })
                }
            ScrollView {
                VStack {
                    Text(topic.name.capitalized)
                        .font(.largeTitle.bold())
                        .fontDesign(.rounded)
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.5)
                            .foregroundStyle(Color.accentColor)
                            .frame(width: 130, height: 50)
                            .overlay {
                                Text("\((topic.slides ?? []).count)  pages")
                                    .font(.headline)
                                    .onAppear {
                                        print(percentageOf())
                                    }
                            }
//                        Spacer(minLength: 0)
                        if (topic.slides ?? []).count != 0 {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(percentageOf()) %")
                                        .font(.headline)
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(maxWidth: 210)
                                        .frame(width: percentageFrom())
                                        .foregroundStyle(Color.accentColor)
                                }
                                Spacer(minLength: 0)
                            }
                            .padding(.leading, 10)
                        }
                    }
                    .padding(.horizontal, 10)
                    Text(topic.description)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .padding(.horizontal)
                        .background(
                            Color.accentColor.opacity(0.2)
                        )
                        .cornerRadius(10)
                        .padding()
                    
                    Button(action: {
                        appNavigation.path.append(.slide_views(topic))
                    }, label: {
                        Text("Start Learning")
                            .font(.title.bold())
                            .fontDesign(.rounded)
                            .frame(height: 75)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(
                                Color.accentColor
                            )
                            .cornerRadius(20)
                            .padding(.horizontal)
                        
                    })
                }
            }
            .padding(.top, -50)
        }
        .navigationBarBackButtonHidden()
        
    }
    
    func percentageOf() -> Int {
        return (100 * readPage) / (((topic.slides)?.count == 0 ? 1 : (topic.slides)?.count) ?? 1)
    }
    
    func percentageFrom() -> CGFloat {
        return CGFloat((210 * percentageOf()) / 100)
    }
}

#Preview {
    NavigationStack {
        TopicDetailScreen(topic: Topic(topicId: "123", name: "solar system", description: "dsfsadakhdsjakhdkjshda sdhaskhd kjahd kjahs dkjhak dhasj dhaskj dhaskh", imageUrl: "https://img.freepik.com/premium-photo/science-background-design_974729-4517.jpg"))
    }
}

struct TopicImageView2: View {
    let topic: Topic
    @StateObject private var imageCacher: ImageCacher
    
    init(topic: Topic, url: String, key: String) {
        self.topic = topic
        _imageCacher = StateObject(wrappedValue: ImageCacher(url: url, key: key))
    }
    
    var body: some View {
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
    }
}
