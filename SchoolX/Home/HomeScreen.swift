//
//  HomeScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 13/10/23.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var appNavigation: AppNavigation
    @StateObject private var vm = HomeViewModel()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Discover")
                        .font(.largeTitle.bold())
                    Spacer()
                }
                .padding(.horizontal)
                if !vm.discoverTopics.isEmpty {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(vm.discoverTopics) { topic in
                                DiscroverCard(topic: topic)
                            }
                        }
                    }
                } else {
                    ProgressView()
                        .frame(height: 150)
                }
                HStack {
                    Text("News")
                        .font(.largeTitle.bold())
                    Spacer()
                }
                ForEach(0..<10) { idx in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.accent.gradient.opacity(0.2))
                        .frame(height: 100)
                        .overlay {
                            Text("News number \(idx+1)")
                                .font(.largeTitle.bold())
                        }
                        .padding()
                }
            }
        }
        .task(priority: .high, {
            do {
                try await vm.getTopics()
            } catch {
                print("Error")
            }
        })
        .toolbar(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    func DiscroverCard(topic: Topic) -> some View {
        VStack {
            Spacer()
            HStack {
                Text(topic.name)
                    .font(.headline)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.ultraThinMaterial)
            )
        }
        .frame(width: 150, height: 150)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.accent.gradient)
                .overlay {
                    Text("💻")
                        .font(.largeTitle)
                }
                .padding()
        )
        .onTapGesture {
            appNavigation.path.append(.subject_topics_detail(topic))
        }
    }
}

#Preview {
    HomeScreen()
}
