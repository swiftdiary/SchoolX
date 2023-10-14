//
//  Date+Ext.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import Foundation

extension Date {
    
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
    
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func getWeekDay() -> Int {
        let weekday = Calendar.current.component(.weekday, from: self)
        return weekday
    }
    
    func getWeekDates() -> [Date] {
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: self)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: self)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: self) }
        return days
    }
    
    func getDayInMonth() -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    static var selectedDay: Int {
        get {
            Date().getWeekDay() - 1
        }
        set {
            
        }
    }
    
    func checkByWeekDay() -> Bool {
        let weekDay = self.getWeekDay()
        if weekDay == Date.selectedDay {
            return true
        } else {
            return false
        }
    }
    
}
