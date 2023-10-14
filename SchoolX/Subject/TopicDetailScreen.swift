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
    
    var body: some View {
        VStack {
            SlidesView(topic: topic, url: topic.imageUrl ?? "", key: topic.topicId)
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
                            }
                        Spacer(minLength: 0)
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
                    .padding(.horizontal)
                    Text(topic.description)
                    
                }
            }
            .padding(.top, -90)
        }
        
    }
    
    func percentageOf() -> Int {
        return (100 * readPage) / ([5,6,7, 8] ).count
    }
    
    func percentageFrom() -> CGFloat {
        return CGFloat((210 * percentageOf()) / 100)
    }
}

#Preview {
    NavigationStack {
        TopicDetailScreen(topic: Topic(topicId: "123", name: "solar system", description: "dsf", imageUrl: "https://img.freepik.com/premium-photo/science-background-design_974729-4517.jpg"))
    }
}

struct SlidesView: View {
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
