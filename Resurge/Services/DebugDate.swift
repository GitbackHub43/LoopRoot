import Foundation

/// Global date override for debug testing.
/// When `offsetDays` is set, all app date checks use the simulated date.
/// REMOVE before App Store submission.
enum DebugDate {
    /// Number of days to offset from real today. 0 = real time.
    static var offsetDays: Int {
        get { UserDefaults.standard.integer(forKey: "debugDateOffset") }
        set { UserDefaults.standard.set(newValue, forKey: "debugDateOffset") }
    }

    /// Use this instead of Date() everywhere in the app.
    /// Returns real date + offset days.
    static var now: Date {
        if offsetDays == 0 { return Date() }
        return Calendar.current.date(byAdding: .day, value: offsetDays, to: Date()) ?? Date()
    }

    /// Start of the simulated "today"
    static var startOfToday: Date {
        Calendar.current.startOfDay(for: now)
    }

    /// Formatted date string for display
    static var todayString: String {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f.string(from: now)
    }

    /// Reset to real time
    static func reset() {
        offsetDays = 0
    }
}
