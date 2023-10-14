//
//  SubjectScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import SwiftUI

struct SubjectScreen: View {
    @StateObject private var viewModel = SubjectViewModel()
    var body: some View {
        List {
            ForEach(SubjectType.allCases) { c in
                Text(c.rawValue.uppercased())
                    .frame(height: 100)
            }
        }
        .listStyle(.grouped)
    }
}

#Preview {
    SubjectScreen()
}
