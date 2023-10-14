//
//  ContentView.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 13/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appNavigation = AppNavigation()
    @StateObject private var viewModel = AuthenticationViewModel()
    @AppStorage("isSignedIn") private var isSignedIn: Bool = false
    var body: some View {
        NavigationStack(path: $appNavigation.path) {
            VStack {
                SplashScreen()
                    .onAppear {
                        do {
                            let _ = try AuthenticationManager.shared.getAuthenticatedUser()
                            withAnimation(.bouncy) {
                                isSignedIn = true
                            }
                        } catch {
                            withAnimation(.bouncy) {
                                isSignedIn = false
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            if isSignedIn {
                                withAnimation(.bouncy) {
                                    appNavigation.path.append(.home)
                                }
                            } else {
                                withAnimation(.bouncy) {
                                    appNavigation.path.append(.signIn)
                                }
                            }
                        }
                    }
            }
            .onAppear(perform: {
                let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                isSignedIn = authUser != nil
                
            })
            .navigationDestination(for: AppNavigationPath.self) { value in
                switch value {
                case .signIn: 
                    AuthScreen()
                        .environmentObject(appNavigation)
                        .environmentObject(viewModel)
                case .signInWithEmail:
                    AuthEmailScreen()
                        .environmentObject(appNavigation)
                        .environmentObject(viewModel)
                case .home:
                    TabBarView()
                        .environmentObject(appNavigation)
                        .environmentObject(viewModel)
                case .profile_editName:
                    EditNameScreen()
                        .environmentObject(appNavigation)
                        .environmentObject(viewModel)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
