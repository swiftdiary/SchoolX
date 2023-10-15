//
//  ProfileScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject private var authViewModel: AuthenticationViewModel
    @EnvironmentObject private var appNavigation: AppNavigation
    @AppStorage("isSignedIn") private var isSignedIn: Bool = false
    
    var body: some View {
        List {
            Section("Settings") {
                Button(action: {
                    withAnimation(.bouncy) {
                        appNavigation.path.append(.profile_editName)
                    }
                }, label: {
                    Text("Edit Name")
                })
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Button(action: {
                        do {
                            try authViewModel.signOut()
                            isSignedIn = false
                            withAnimation(.bouncy) {
                                appNavigation.path = [.signIn]
                            }
                        } catch {
                            print("Couldn't Sign Out")
                        }
                    }, label: {
                        Text("Log Out")
                    })
                }
                .foregroundStyle(.red)
            }
            Section {
                EmptyView()
            } footer: {
                Text("Legal information about company...")
            }

        }
    }
}

#Preview {
    ProfileScreen()
}
