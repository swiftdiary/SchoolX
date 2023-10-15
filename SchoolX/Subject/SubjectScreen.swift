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
                ExtractedView(c: c, url: c.imageUrl, key: c.rawValue)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Subjects")
    }
}

#Preview {
    NavigationStack {
        SubjectScreen()
    }
}

struct ExtractedView: View {
    var c: SubjectType
    @EnvironmentObject private var appNavigation: AppNavigation
    @StateObject private var imageCacher: ImageCacher
    
    init(c: SubjectType, url: String, key: String) {
        self.c = c
        _imageCacher = StateObject(wrappedValue: ImageCacher(url: url, key: key))
    }
    
    var body: some View {
        HStack {
            Spacer()
            HStack {
                Text("\(c.rawValue.capitalized)")
                    .font(.title2.bold())
                    .foregroundStyle(Color.white)
                    .fontDesign(.rounded)
            }
            .background(
//                AsyncImage(url: URL(string: c.imageUrl)) { image in
//                    image.resizable()
//                } placeholder: {
//                    ProgressView()
//                }
//                    .frame(width: 350, height: 100)
//                    .cornerRadius(10)
                VStack {
                    if imageCacher.isLoading {
                        ProgressView()
                            .frame(width: 300, height: 200, alignment: .center)
                    } else if let image = imageCacher.image  {
                        Image(uiImage: image)
                           .resizable()
                           .frame(width: 350, height: 100)
                           .cornerRadius(10)
                   }
                }
                
            )
            .frame(height: 100)
            .onTapGesture {
                appNavigation.path.append(.subject_topics(c))
            }
            Spacer()
        }
    }
}
