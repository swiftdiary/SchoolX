//
//  ActivityScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 14/10/23.
//

import SwiftUI

struct ProgressScreen: View {
    @Namespace var namespace
    @StateObject private var viewModel = ProgressViewModel()
    @State private var selectedDay: Int = Date().getWeekDay() - 1
    @State private var completeFloat: CGFloat = 0.01
    let weekSymbols: [String] = ["S", "M", "T", "W", "T", "F", "S"]
    let weekDates: [Date] = Date().getWeekDates()
    
    var body: some View {
        VStack {
            if viewModel.user != nil {
                WeekDaysView()
                Divider()
                FeedView()
                Divider()
                HistoryView()
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
                viewModel.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
                if let user = viewModel.user, let progress = user.progress {
                    guard let beginDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 1, of: Date.now.getWeekDay() == selectedDay ? Date.now : Date.now.addingTimeInterval(
                        TimeInterval((60*60*24) * ((Date.now.getWeekDay()-1) - selectedDay))
                    )) else { return }
                    let endDate = beginDate.addingTimeInterval(60*60*24)
                    withAnimation(.bouncy) {
                        viewModel.getHistory(history: progress.milestone.history, dateRange: beginDate..<endDate)
                    }
                }
            } catch {
                print(error)
            }
        }
        .onChange(of: selectedDay, { oldValue, newValue in
            if let user = viewModel.user, let progress = user.progress {
                guard let beginDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 1, of: Date.now.getWeekDay() == newValue ? Date.now : Date.now.addingTimeInterval(
                    TimeInterval((60*60*24) * ((Date.now.getWeekDay()-1) - newValue))
                )) else { return }
                let endDate = beginDate.addingTimeInterval(60*60*24)
                withAnimation(.bouncy) {
                    viewModel.getHistory(history: progress.milestone.history, dateRange: beginDate..<endDate)
                }
            }
        })
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.bouncy) {
                    let divResult = CGFloat(Float(viewModel.getUserOpenedTimes()) / Float(viewModel.getUserDailyProgressCount()))
                    completeFloat = divResult > 1 ? 1 : divResult
                    print(completeFloat)
                }
            }
        }
    }
    
    @ViewBuilder
    func HistoryView() -> some View {
        List(viewModel.historyItems) { item in
            HStack {
                VStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .fill(.accent.gradient)
                        .frame(width: 8)
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("Last activity:")
                            .font(.headline)
                            .foregroundStyle(.accent)
                        Text(viewModel.getUserOpenedDate(from: item))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Time spent:")
                            .font(.headline)
                        Text("\(viewModel.getUserSpentTime(from: item))")
                            .font(.subheadline)
                    }
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
    }
    
    @ViewBuilder
    func FeedView() -> some View {
        HStack {
            VStack {
                HStack {
                    Text("Your daily goal")
                        .font(.title.bold())
                    Spacer()
                    Text("\(viewModel.getUserDailyProgressCount())")
                        .font(.title.bold())
                        .foregroundStyle(.accent)
                }
                .padding()
                GeometryReader { proxy in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .fill(.accent)
                                .frame(width: proxy.size.width*completeFloat, height: 10)
                                .transition(.move(edge: .leading))
                        }
                        HStack {
                            Text("\(String(format: "%.0f", completeFloat*100))% complete")
                                .font(.headline.bold())
                                .foregroundStyle(.accent)
                        }
                    }
                }
            }
        }
        .frame(height: 150)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.ultraThickMaterial)
                .padding(5)
        )
    }
    
    // MARK: Week Days
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
