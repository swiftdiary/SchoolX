//
//  ContentView.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 13/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appNavigation = AppNavigation()
    var body: some View {
        NavigationStack(path: $appNavigation.path) {
            VStack {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            if appNavigation.isSignedIn {
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
                appNavigation.isSignedIn = authUser != nil
                
            })
            .navigationDestination(for: AppNavigationPath.self) { value in
                switch value {
                case .signIn: 
                    AuthScreen()
                        .environmentObject(appNavigation)
                case .home:
                    HomeScreen()
                        .environmentObject(appNavigation)
                default:
                    Text("HEHEHEHEH")
                        .environmentObject(appNavigation)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
