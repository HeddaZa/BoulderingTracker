# 🧗 Bouldering Tracker

![iOS](https://img.shields.io/badge/iOS-14.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-2.0+-green.svg)
![Status](https://img.shields.io/badge/Status-Work%20in%20Progress-yellow.svg)
![Contributions](https://img.shields.io/badge/Contributions-Welcome-brightgreen.svg)

A SwiftUI iOS app to track your bouldering sessions and climbing progress by date.

## 🌟 Features

- 📅 **Calendar View** - Browse and select dates to view and add boulders for specific days
- 🏔️ **Boulder Management** - Add climbing sessions with name and difficulty level
- 📊 **Statistics** - Track your total climbs and highest difficulty grade
- 📋 **All Climbs View** - See your complete climbing history
- 💾 **Local Storage** - All data is saved locally on your device using UserDefaults
- 🎯 **Date-Based Organization** - Organize your climbing sessions by date

## 🛠️ Tech Stack

- **Swift** - Programming language
- **SwiftUI** - User interface framework
- **Xcode** - Development environment

## 📦 Project Structure

```
BoulderingTracker/
├── Models/
│   └── Boulder.swift
├── ViewModels/
│   └── BoulderViewModel.swift
├── Views/
│   ├── ContentView.swift
│   ├── CalendarView.swift
│   └── AddBoulderView.swift
├── BoulderingTrackerApp.swift
└── Assets/
```

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/HeddaZa/BoulderingTracker.git
   ```

2. Open the project in Xcode:
   ```bash
   cd BoulderingTracker
   open BoulderingTracker/BoulderingTracker.xcodeproj
   ```

3. Build and run the app on the iOS simulator or your device (Cmd+R)

## 📱 How to Use

### 📅 Calendar Tab
- Navigate through months using the arrow buttons
- Tap a date to select it
- Orange dots indicate days with boulders
- Tap the **+** button to add a new boulder for the selected date
- View all boulders for that day below the calendar

### 📋 All Climbs Tab
- See statistics: Total climbs and highest grade
- Browse all your climbing sessions in reverse chronological order
- Swipe left to delete entries
- Tap **+** to add a new boulder with today's date

### ➕ Adding a Boulder
1. Tap the **+** button
2. Select the date for your climbing session
3. Enter the boulder name (e.g., "The Crimper")
4. Choose the difficulty level (4A - 9A)
5. Tap "Add Boulder"

## 🎯 Difficulty Levels

Supported grades: 4A, 4B, 4C, 5A, 5B, 5C, 6A, 6A+, 6B, 6B+, 6C, 6C+, 7A, 7B, 7C, 8A, 8A+, 8B, 8B+, 8C, 8C+, 9A

## 💡 Features Overview

### Boulder Model
- ID (UUID)
- Name
- Difficulty
- Date

### Statistics
- **Total Climbs** - Total number of boulders logged
- **Highest Grade** - Your best achieved difficulty level

## 🔄 Data Persistence

All boulders are automatically saved to your device's local storage. Your climbing data persists between app sessions.

## 👤 Author

**Hedda** - [@HeddaZa](https://github.com/HeddaZa)

---

**Happy Climbing! 🧗‍♀️🧗‍♂️**
