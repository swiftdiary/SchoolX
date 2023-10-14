//
//  HomeScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 13/10/23.
//

import SwiftUI

struct HomeScreen: View {
    
    var body: some View {
        VStack {
            ScrollView {
                TabBarPreviewMode()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationTitle("Discover")
    }
}

#Preview {
    HomeScreen()
}
