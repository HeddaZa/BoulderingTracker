import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: BoulderViewModel
    @State private var selectedDate = Date()
    @State private var showingAddBoulderView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Calendar
                VStack(spacing: 12) {
                    // Month/Year Header
                    HStack {
                        Button(action: { goToPreviousMonth() }) {
                            Image(systemName: "chevron.left")
                                .font(.headline)
                        }
                        Spacer()
                        Text(monthYearString(selectedDate))
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        Button(action: { goToNextMonth() }) {
                            Image(systemName: "chevron.right")
                                .font(.headline)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Day of Week Headers
                    HStack(spacing: 0) {
                        ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                            Text(day)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Calendar Grid
                    let days = getDaysInMonth(for: selectedDate)
                    VStack(spacing: 8) {
                        ForEach(0..<(days.count / 7 + (days.count % 7 > 0 ? 1 : 0)), id: \.self) { week in
                            HStack(spacing: 0) {
                                ForEach(0..<7) { day in
                                    let index = week * 7 + day
                                    if index < days.count {
                                        CalendarDayView(
                                            date: days[index],
                                            isSelected: Calendar.current.isDate(days[index], inSameDayAs: selectedDate),
                                            hasBoulders: viewModel.getBoulders(for: days[index]).count > 0
                                        )
                                        .onTapGesture {
                                            selectedDate = days[index]
                                        }
                                    } else {
                                        Color.clear
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                            }
                            .frame(height: 44)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding()
                
                // Selected Date and Boulders
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(formattedDateString(selectedDate))
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        Button(action: { showingAddBoulderView = true }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title3)
                                .foregroundColor(.orange)
                        }
                    }
                    .padding(.horizontal)
                    
                    let bouldersForSelectedDate = viewModel.getBoulders(for: selectedDate)
                    if bouldersForSelectedDate.isEmpty {
                        VStack(spacing: 8) {
                            Image(systemName: "mountain.2")
                                .font(.system(size: 32))
                                .foregroundColor(.gray)
                            Text("No boulders on this date")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    } else {
                        VStack(spacing: 8) {
                            ForEach(bouldersForSelectedDate) { boulder in
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(boulder.name)
                                            .fontWeight(.semibold)
                                    }
                                    Spacer()
                                    Text(boulder.difficulty)
                                        .font(.headline)
                                        .foregroundColor(.orange)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingAddBoulderView) {
                AddBoulderView(viewModel: viewModel, isPresented: $showingAddBoulderView, preselectedDate: selectedDate)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func getDaysInMonth(for date: Date) -> [Date] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        
        var days: [Date] = []
        for day in 1...numDays {
            var dateComponents = calendar.dateComponents([.year, .month], from: date)
            dateComponents.day = day
            if let date = calendar.date(from: dateComponents) {
                days.append(date)
            }
        }
        return days
    }
    
    private func monthYearString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    private func formattedDateString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
    
    private func goToPreviousMonth() {
        let calendar = Calendar.current
        if let previousMonth = calendar.date(byAdding: .month, value: -1, to: selectedDate) {
            selectedDate = previousMonth
        }
    }
    
    private func goToNextMonth() {
        let calendar = Calendar.current
        if let nextMonth = calendar.date(byAdding: .month, value: 1, to: selectedDate) {
            selectedDate = nextMonth
        }
    }
}

struct CalendarDayView: View {
    let date: Date
    let isSelected: Bool
    let hasBoulders: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Text("\(Calendar.current.component(.day, from: date))")
                    .font(.system(.caption, design: .default))
                    .fontWeight(.semibold)
                    .foregroundColor(isSelected ? .white : .primary)
                Spacer()
            }
            
            if hasBoulders {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 4, height: 4)
                    .padding(4)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isSelected ? Color.orange : Color(.systemBackground))
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(isSelected ? Color.clear : Color(.systemGray6), lineWidth: 1)
        )
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(viewModel: BoulderViewModel())
    }
}
