import SwiftUI

@main
struct KigoParentApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}

final class AppState: ObservableObject {
    @Published var children: [ChildProfile] = ChildProfile.samples
    @Published var scheduleItems: [ScheduleItem] = ScheduleItem.samples
    @Published var messages: [MessageThread] = MessageThread.samples
    @Published var schoolCommandMetrics: [SchoolCommandMetric] = SchoolCommandMetric.samples
    @Published var kigoPulseSignals: [KigoPulseSignal] = KigoPulseSignal.losAngelesSamples

    func updateChildStatus(_ childID: ChildProfile.ID, status: ChildProfile.Status) {
        children = children.map { child in
            guard child.id == childID else { return child }
            var updated = child
            updated.status = status
            return updated
        }
    }

    func markThreadAsRead(_ threadID: MessageThread.ID) {
        messages = messages.map { thread in
            guard thread.id == threadID else { return thread }
            var updated = thread
            updated.unreadCount = 0
            return updated
        }
    }

    func sendQuickMessage(to threadID: MessageThread.ID, content: String) {
        let newMessage = Message(
            id: UUID(),
            sender: "You",
            isFromStaff: false,
            content: content,
            timestamp: Date()
        )

        messages = messages.map { thread in
            guard thread.id == threadID else { return thread }
            var updated = thread
            updated.messages.insert(newMessage, at: 0)
            updated.preview = content
            updated.updatedAt = newMessage.timestamp
            updated.unreadCount = 0
            return updated
        }
    }
}
