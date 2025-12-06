import Foundation

struct ChildProfile: Identifiable, Hashable {
    enum Status: String {
        case checkedIn = "Checked in"
        case enRoute = "En route"
        case pickupReady = "Ready for pickup"
    }

    let id: UUID
    var name: String
    var age: Int
    var classroom: String
    var allergies: String
    var status: Status
    var pickupContact: String
    var note: String

    static let samples: [ChildProfile] = [
        ChildProfile(
            id: UUID(),
            name: "Emi",
            age: 5,
            classroom: "Butterflies",
            allergies: "Peanuts",
            status: .checkedIn,
            pickupContact: "Taylor (Mom)",
            note: "Napped well yesterday."
        ),
        ChildProfile(
            id: UUID(),
            name: "Noah",
            age: 7,
            classroom: "Robins",
            allergies: "None",
            status: .enRoute,
            pickupContact: "Jordan (Dad)",
            note: "Needs inhaler in backpack."
        )
    ]
}

struct ScheduleItem: Identifiable, Hashable {
    enum Kind: String {
        case arrival = "Arrival"
        case learning = "Learning"
        case meal = "Meal"
        case activity = "Activity"
        case pickup = "Pickup"
    }

    let id: UUID
    var title: String
    var time: String
    var notes: String
    var kind: Kind

    static let samples: [ScheduleItem] = [
        ScheduleItem(id: UUID(), title: "Drop-off", time: "08:30", notes: "Bring library book", kind: .arrival),
        ScheduleItem(id: UUID(), title: "Reading circle", time: "09:00", notes: "Focus on animals", kind: .learning),
        ScheduleItem(id: UUID(), title: "Lunch", time: "11:45", notes: "Packed lunch ok", kind: .meal),
        ScheduleItem(id: UUID(), title: "Parent-Teacher call", time: "12:30", notes: "Zoom link in messages", kind: .activity),
        ScheduleItem(id: UUID(), title: "Pick-up", time: "15:15", notes: "Request aftercare next week", kind: .pickup)
    ]
}

struct Message: Identifiable, Hashable {
    let id: UUID
    var sender: String
    var isFromStaff: Bool
    var content: String
    var timestamp: Date
}

struct MessageThread: Identifiable, Hashable {
    let id: UUID
    var participant: String
    var preview: String
    var updatedAt: Date
    var unreadCount: Int
    var messages: [Message]

    static let samples: [MessageThread] = [
        MessageThread(
            id: UUID(),
            participant: "Ms. Chen",
            preview: "Emi loved the reading circle today!",
            updatedAt: Date(),
            unreadCount: 1,
            messages: [
                Message(
                    id: UUID(),
                    sender: "Ms. Chen",
                    isFromStaff: true,
                    content: "Emi loved the reading circle today!",
                    timestamp: Date()
                ),
                Message(
                    id: UUID(),
                    sender: "You",
                    isFromStaff: false,
                    content: "Amazing—thanks for the update!",
                    timestamp: Date().addingTimeInterval(-1200)
                )
            ]
        ),
        MessageThread(
            id: UUID(),
            participant: "Coach Ivan",
            preview: "Practice moved to Thursday; ok to attend?",
            updatedAt: Date().addingTimeInterval(-7200),
            unreadCount: 0,
            messages: [
                Message(
                    id: UUID(),
                    sender: "Coach Ivan",
                    isFromStaff: true,
                    content: "Practice moved to Thursday due to weather. Is Noah ok to attend?",
                    timestamp: Date().addingTimeInterval(-7200)
                ),
                Message(
                    id: UUID(),
                    sender: "You",
                    isFromStaff: false,
                    content: "Yes, thanks for letting us know!",
                    timestamp: Date().addingTimeInterval(-6800)
                )
            ]
        )
    ]
}
