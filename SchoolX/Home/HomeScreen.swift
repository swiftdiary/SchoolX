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
            Text("Hello, World!")
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    HomeScreen()
}
