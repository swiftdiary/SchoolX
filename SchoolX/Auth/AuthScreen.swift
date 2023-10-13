//
//  AuthScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 13/10/23.
//

import SwiftUI

struct AuthScreen: View {
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.title.bold())
            Button {
                
            } label: {
                Text("Continue with Apple")
            }
            Button {
                
            } label: {
                Text("Continue with Google")
            }
            Button {
                
            } label: {
                Text("Continue using Email")
            }
        }
    }
}

#Preview {
    AuthScreen()
}
