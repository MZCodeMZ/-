import SwiftUI

struct ChildProfilesView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        List {
            ForEach(appState.children) { child in
                NavigationLink(destination: ChildDetailView(child: child)) {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(child.name)
                                .font(.headline)
                            Spacer()
                            statusPill(status: child.status)
                        }
                        HStack(spacing: 8) {
                            Label("Age: \(child.age)", systemImage: "figure.child")
                            Label(child.classroom, systemImage: "person.2")
                        }
                        .foregroundStyle(.secondary)
                        Text(child.note)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Children")
    }

    private func statusPill(status: ChildProfile.Status) -> some View {
        Text(status.rawValue)
            .font(.caption.weight(.semibold))
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(statusColor(for: status).opacity(0.15), in: Capsule())
            .foregroundStyle(statusColor(for: status))
    }

    private func statusColor(for status: ChildProfile.Status) -> Color {
        switch status {
        case .checkedIn: return .green
        case .enRoute: return .orange
        case .pickupReady: return .blue
        }
    }
}

struct ChildDetailView: View {
    let child: ChildProfile

    var body: some View {
        Form {
            Section(header: Text("Overview")) {
                LabeledContent("Name", value: child.name)
                LabeledContent("Age", value: "\(child.age)")
                LabeledContent("Classroom", value: child.classroom)
                LabeledContent("Status", value: child.status.rawValue)
            }

            Section(header: Text("Health")) {
                LabeledContent("Allergies", value: child.allergies)
                LabeledContent("Pickup contact", value: child.pickupContact)
            }

            Section(header: Text("Notes")) {
                Text(child.note)
            }
        }
        .navigationTitle(child.name)
    }
}

#Preview {
    NavigationStack {
        ChildProfilesView()
            .environmentObject(AppState())
    }
}
