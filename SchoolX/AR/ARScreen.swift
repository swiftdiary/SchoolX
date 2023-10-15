//
//  ARScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 15/10/23.
//

import SwiftUI

struct ARScreen: View {
    var body: some View {
        CustomARViewRepresentable()
            .ignoresSafeArea()
            .overlay(
                Text("Hello")
                    .background(Color.white)
                , alignment: .bottom
            )
    }
}

#Preview {
    ARScreen()
}
