//
//  SplashScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 13/10/23.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack {
            LottieView(name: "loading")
        }
        .padding()
    }
}

#Preview {
    SplashScreen()
}
