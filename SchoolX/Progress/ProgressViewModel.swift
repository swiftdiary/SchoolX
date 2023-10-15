//
//  ProgressViewModel.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import Foundation

final class ProgressViewModel: ObservableObject {
    @Published var historyItems: [Milestone.History] = []
    @Published var user: UserModel?
    
    func getHistory(history: [Milestone.History], dateRange: Range<Date>) {
        historyItems = history.filter({ dateRange.contains($0.date) })
    }
    
    func getUserDailyProgressCount() -> Int {
        return user?.progress?.milestone.estimatedCount ?? 1
    }
    
    func getUserOpenedDate(from historyItem: Milestone.History) -> String {
        return historyItem.date.format("MM/dd/YYYY hh:mm:ss")
    }
    
    func getUserSpentTime(from historyItem: Milestone.History) -> Int {
        return historyItem.spentTime
    }
    
    func getUserOpenedTimes() -> Int {
        return historyItems.count
    }
}
