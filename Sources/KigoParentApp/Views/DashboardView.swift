import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var appState: AppState

    private var primaryChild: ChildProfile? { appState.children.first }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                quickActions
                upcomingSection
                remindersSection
            }
            .padding()
        }
        .navigationTitle("Kigo for Parents")
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Welcome back")
                .font(.title2.weight(.semibold))
            if let child = primaryChild {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Today's focus: \(child.name) in \(child.classroom)")
                        .foregroundStyle(.secondary)
                    statusBadge(for: child.status)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var quickActions: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader(title: "Quick actions", systemImage: "bolt.fill")
            HStack(spacing: 12) {
                if let child = primaryChild {
                    actionButton(title: "Check in", systemImage: "checkmark.circle.fill") {
                        appState.updateChildStatus(child.id, status: .checkedIn)
                    }
                }
                actionButton(title: "Running late", systemImage: "clock.fill") {
                    if let thread = appState.messages.first {
                        appState.sendQuickMessage(to: thread.id, content: "We're running 5 minutes late today.")
                    }
                }
                actionButton(title: "Message teacher", systemImage: "bubble.left.fill") {
                    if let thread = appState.messages.first {
                        appState.sendQuickMessage(to: thread.id, content: "Could we chat after pickup?")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var upcomingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader(title: "Today's schedule", systemImage: "calendar")
            ForEach(appState.scheduleItems.prefix(3)) { item in
                ScheduleCard(item: item)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var remindersSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader(title: "Messages", systemImage: "bubble.left")
            ForEach(appState.messages.prefix(2)) { thread in
                MessageRow(thread: thread)
                Divider()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func sectionHeader(title: String, systemImage: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
                .foregroundStyle(.accent)
            Text(title)
                .font(.headline)
        }
    }

    private func actionButton(title: String, systemImage: String, action: (() -> Void)? = nil) -> some View {
        Button(action: action ?? {}) {
            HStack {
                Image(systemName: systemImage)
                Text(title)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }

    private func statusBadge(for status: ChildProfile.Status) -> some View {
        Text(status.rawValue)
            .font(.caption.weight(.semibold))
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(statusColor(for: status).opacity(0.15), in: Capsule())
            .foregroundStyle(statusColor(for: status))
    }

    private func statusColor(for status: ChildProfile.Status) -> Color {
        switch status {
        case .checkedIn:
            return .green
        case .enRoute:
            return .orange
        case .pickupReady:
            return .blue
        }
    }
}

#Preview {
    NavigationStack {
        DashboardView()
            .environmentObject(AppState())
    }
}
