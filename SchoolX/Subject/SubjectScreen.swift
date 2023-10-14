//
//  SubjectScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import SwiftUI

struct SubjectScreen: View {
    @StateObject private var viewModel = SubjectViewModel()
    @EnvironmentObject private var appNavigation: AppNavigation
    var body: some View {
        List {
            ForEach(SubjectType.allCases) { c in
                HStack {
                    Text("EFEFEF")
                }
                .frame(height: 100)
                .onTapGesture {
                    appNavigation.path.append(.subject_topics(c))
                }
            }
        }
        .listStyle(.grouped)
    }
}

#Preview {
    SubjectScreen()
}
