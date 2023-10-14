//
//  ActivityScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import SwiftUI

struct ProgressScreen: View {
    @State private var user: UserModel?
    let fakeMilestone = Milestone(estimatedCount: 2)
    let fakeBadges = [Badge(name: "B1", lottie: "B1 lottie", skill: Topic(topicId: "rewr", name: "resr", description: "resr", imageUrl: ""))]
    let fakeProgress: Progress
    init() {
        self.fakeProgress = Progress(milestone: self.fakeMilestone, badges: self.fakeBadges)
    }
    var body: some View {
        VStack {
            Text("User: ")
            if let user {
                Text(user.name ?? "feef")
                Text(user.email ?? "@@@")
                Text("Progress")
                Text("\(user.progress?.milestone.estimatedCount ?? 1)")
            }
        }
        .task {
            do {
                let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
                user = try await UserManager.shared.getUser(userId: authDataResult.uid)
                try await UserManager.shared.updateUserProgress(userId: authDataResult.uid, progress: fakeProgress)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ProgressScreen()
}
