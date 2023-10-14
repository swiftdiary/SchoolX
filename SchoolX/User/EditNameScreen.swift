//
//  EditNameScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import SwiftUI

struct EditNameScreen: View {
    @EnvironmentObject private var appNavigation: AppNavigation
    @State private var user: UserModel?
    @State private var text: String = ""
    var body: some View {
        List {
            Section("Profile Settings") {
                Text("Email: \(user?.email ?? "")")
                Text("Current name: \(user?.name ?? "")")
                HStack {
                    Text("New name: ")
                    TextField("ex. Joe", text: $text)
                }
                HStack {
                    Image(systemName: "square.and.arrow.down.fill")
                    Button {
                        Task {
                            do {
                                if let userId = user?.userId {
                                    try await UserManager.shared.updateUserName(userId: userId, name: text)
                                    _ = appNavigation.path.popLast()
                                }
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        Text("Save")
                    }
                }
                .foregroundStyle(.accent)
            }
        }
        .task(priority: .high) {
            if let authResult = try? AuthenticationManager.shared.getAuthenticatedUser() {
                user = try? await UserManager.shared.getUser(userId: authResult.uid)
            }
        }
    }
}

#Preview {
    EditNameScreen()
}
