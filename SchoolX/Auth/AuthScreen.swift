//
//  AuthScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 13/10/23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices

struct AuthScreen: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @EnvironmentObject private var appNavigation: AppNavigation
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.title.bold())
            Button(action: {
                Task {
                    do {
                        try await viewModel.signInApple()
                        
                    } catch {
                        print(error)
                    }
                }
            }, label: {
                SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                    .allowsHitTesting(false)
            })
            .frame(height: 55)
            Divider()
                .padding()
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                        
                    } catch {
                        print(error)
                    }
                }
            }
            .frame(height: 55)
            Divider()
                .padding()
            Button {
                appNavigation.path.append(.signInWithEmail)
            } label: {
                Text("Continue using Email")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.gray.gradient.opacity(0.3))
            .font(.headline)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .foregroundStyle(.accent)
        }
        .padding()
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    AuthScreen()
}
