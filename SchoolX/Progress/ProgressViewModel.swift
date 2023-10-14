//
//  ProgressViewModel.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import Foundation

final class ProgressViewModel: ObservableObject {
    @Published var feedItems: [Milestone.History] = []
    
    func getFeed(history: [Milestone.History], dateRange: Range<Date>) {
        feedItems = history.filter({ dateRange.contains($0.date) })
    }
    
}
