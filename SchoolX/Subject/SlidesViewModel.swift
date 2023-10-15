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
    
    
    func getValueFromIndex(index: Int, slides: [Slide]) -> Slide {
        var s = 0
        for i in 0..<slides.count {
            if index == s {
                return slides[s]
            }
            s += 1
        }
        return slides.first ?? Slide(imageUrl: "", title: "x", description: "x")
    }
    
    func getIndexFromValue(value: Slide, slides: [Slide]) -> Int {
        var s = 0
        for i in slides {
            if i == value {
                return s
            }
            s += 1
        }
        return s
    }
    
    
}
