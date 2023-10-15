//
//  SlidesViewModel.swift
//  SchoolX
//
//  Created by Muhammadjon Madaminov on 15/10/23.
//

import Foundation
import SwiftUI


class SlidesViewModel: ObservableObject {
    @Published var currentSlide: Slide = Slide(imageUrl: "x", title: "x", description: "x")
    @Published var currentIndex: Int = 0
}
