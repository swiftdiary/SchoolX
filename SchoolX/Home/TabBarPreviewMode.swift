//
//  TabBarPreviewMode.swift
//  SchoolX
//
//  Created by Muhammadjon Madaminov on 14/10/23.
//

import SwiftUI

struct TabBarPreviewMode: View {
    @State private var tabItem: Int = 1
    @State private var numberOfItems: Int = 4
    
    var body: some View {
        TabView(selection: $tabItem,
                content:  {
            TabItemView(title: "Subway surfers", category: "Game", photo: .gray).tabItem {
                Text("Tab Label 1")
            }.tag(1)
            TabItemView(title: "Cosmos", category: "Astranomy", photo: .blue).tabItem {
                Text("Tab Label 2")
            }.tag(2)
            TabItemView(title: "Subway surfers", category: "Game", photo: .red).tabItem {
                Text("Tab Label 1")
            }.tag(3)
            TabItemView(title: "Subway surfers", category: "Game", photo: .black).tabItem {
                Text("Tab Label 1")
            }.tag(4)
        })
        .tabViewStyle(.page)
        .frame(width: 350, height: 300)
        .cornerRadius(10)
        
    }
    
    @ViewBuilder func TabItemView(title: String, category: String, photo: Color) -> some View {
        VStack {
            HStack {
                Text(category)
                    .font(.title2.bold())
                Spacer()
            }
            
            HStack {
                Text(title)
                    .font(.title2)
                    .foregroundStyle(Color.secondary)
                Spacer()
            }
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(photo)
        }
    }
}

#Preview {
    TabBarPreviewMode()
}
