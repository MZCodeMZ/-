import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        List {
            ForEach(appState.scheduleItems) { item in
                ScheduleCard(item: item)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Schedule")
    }
}

struct ScheduleCard: View {
    let item: ScheduleItem

    private var iconName: String {
        switch item.kind {
        case .arrival: return "door.left.hand.open"
        case .learning: return "book.fill"
        case .meal: return "fork.knife"
        case .activity: return "sparkles"
        case .pickup: return "car.fill"
        }
    }

    private var iconColor: Color {
        switch item.kind {
        case .arrival: return .blue
        case .learning: return .indigo
        case .meal: return .orange
        case .activity: return .purple
        case .pickup: return .green
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack { 
                Label(item.kind.rawValue, systemImage: iconName)
                    .foregroundStyle(iconColor)
                    .font(.subheadline.weight(.semibold))
                Spacer()
                Label(item.time, systemImage: "clock")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.notes)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
        }
        .padding()
        .background(.quaternary.opacity(0.2), in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NavigationStack {
        ScheduleView()
            .environmentObject(AppState())
    }
}
