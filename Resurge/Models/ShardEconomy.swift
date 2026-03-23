import Foundation

enum ShardAction: String, CaseIterable {
    case dailyLoopComplete
    case morningPlan
    case eveningReview
    case toolCompleted

    var shards: Int {
        switch self {
        case .dailyLoopComplete:    return 15
        case .morningPlan:          return 0
        case .eveningReview:        return 0
        case .toolCompleted:       return 0
        }
    }

    var displayName: String {
        switch self {
        case .dailyLoopComplete:    return "Daily Loop Complete"
        case .morningPlan:          return "Morning Plan"
        case .eveningReview:        return "Evening Review"
        case .toolCompleted:        return "Tool Completed"
        }
    }
}

struct ShardTransaction: Codable, Identifiable {
    var id = UUID()
    let action: String
    let amount: Int
    let date: Date
}
