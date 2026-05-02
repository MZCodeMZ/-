import SwiftUI

struct SchoolCommandView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("School Command")
                    .font(.title2.weight(.bold))
                Text("Live operations view for school staff and parent leaders.")
                    .foregroundStyle(.secondary)

                ForEach(appState.schoolCommandMetrics) { metric in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(metric.title)
                            .font(.headline)
                        Text(metric.value)
                            .font(.system(size: 30, weight: .bold))
                        Text(metric.trend)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.quaternary.opacity(0.2), in: RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
        }
        .navigationTitle("School Command")
    }
}

struct KigoPulseLAView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        List {
            Section("Los Angeles live pulse") {
                ForEach(appState.kigoPulseSignals) { signal in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(signal.label)
                                .font(.headline)
                            Spacer()
                            Text(signal.status)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.accent)
                        }
                        Text(signal.detail)
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                    }
                    .padding(.vertical, 6)
                }
            }

            Section("Impact snapshot") {
                Label("CO₂ saved today: 118 kg", systemImage: "leaf.fill")
                Label("Estimated solo-car trips avoided: 63", systemImage: "car.2.fill")
                Label("Kigo active days streak leaders: 12 families", systemImage: "flame.fill")
            }
        }
        .navigationTitle("Kigo Pulse LA")
    }
}

#Preview {
    NavigationStack {
        KigoPulseLAView()
            .environmentObject(AppState())
    }
}
