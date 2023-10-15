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
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.white)
                    .frame(height: 100)
                    .overlay(content: {
                        Button {
                            ARManager.shared.actionStream.send(.placeBlock(color: .blue))
                        } label: {
                            Text("Add Earth")
                        }
                        .buttonStyle(.borderedProminent)
                    })
                , alignment: .bottom
            )
    }
}

#Preview {
    ARScreen()
}
