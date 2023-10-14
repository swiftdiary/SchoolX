//
//  ActivityScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import SwiftUI

struct ProgressScreen: View {
    @Namespace var namespace
    @State private var user: UserModel?
    @State private var selectedDay: Int = Date().getWeekDay() - 1
    let weekSymbols: [String] = ["S", "M", "T", "W", "T", "F", "S"]
    let weekDates: [Date] = Date().getWeekDates()
    
    var body: some View {
        VStack {
            if let user {
                WeekDaysView()
            } else {
                VStack {
                    LottieView(name: "loading_hamster")
                        .frame(maxHeight: 400)
                    Text("Loading...")
                        .font(.headline)
                        .foregroundStyle(.accent)
                }
            }
        }
        .task(priority: .high) {
            do {
                let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
                user = try await UserManager.shared.getUser(userId: authDataResult.uid)
            } catch {
                print(error)
            }
        }
    }
    
    @ViewBuilder
    func WeekDaysView() -> some View {
        HStack {
            ForEach(0..<7) { day in
                WeekDay(day, isCurrent: day == Date().getWeekDay() - 1, isSelected: selectedDay == day)
                    .onTapGesture {
                        withAnimation(.bouncy) {
                            selectedDay = day
                            Date.selectedDay = day
                        }
                    }
            }
        }
    }
    
    @ViewBuilder
    func WeekDay(_ day: Int, isCurrent: Bool, isSelected: Bool) -> some View {
        ZStack {
            if isSelected {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.accentColor.gradient)
                    .frame(height: 100)
                    .matchedGeometryEffect(id: "WeekDay", in: namespace)
            }
            VStack(spacing: 8) {
                Text(weekSymbols[day])
                    .font(.headline)
                Text("\(weekDates[day].getDayInMonth())")
                    .font(.caption)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .scaleEffect(x: isSelected ? 1.2 : 1, y: isSelected ? 1.2 : 1)
            .foregroundStyle(isSelected ? .white : .primary)
            
            if isCurrent {
                Circle()
                    .frame(width: 5)
                    .offset(y: 35)
                    .foregroundStyle(isSelected ? .white : .primary)
            }
        }
    }
}

#Preview {
    ProgressScreen()
}
