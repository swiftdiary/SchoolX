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
            
            Image("Logo")
                .resizable()
                .frame(width: 200, height: 220)
                .padding(.bottom, 30)
            
            VStack {
                
                
                Text("Welcome!")
                    .font(.title.bold())
                    .fontDesign(.rounded)
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
                        .foregroundStyle(Color.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.accent)
                .font(.headline)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                
            }
            .padding(9)
            .padding(.vertical)
            .toolbar(.hidden, for: .navigationBar)
            .padding(.vertical)
            .background(
                Color.accentColor.opacity(0.15)
            )
            .cornerRadius(15)
            .padding(8)
        }
    }
}

#Preview {
    AuthScreen()
}
