import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                DashboardView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            NavigationStack {
                ScheduleView()
            }
            .tabItem {
                Label("Schedule", systemImage: "calendar")
            }

            NavigationStack {
                MessagesView()
            }
            .tabItem {
                Label("Messages", systemImage: "bubble.left.and.bubble.right.fill")
            }

            NavigationStack {
                ChildProfilesView()
            }
            .tabItem {
                Label("Children", systemImage: "person.3.fill")
            }

            NavigationStack {
                SchoolCommandView()
            }
            .tabItem {
                Label("School", systemImage: "building.2.fill")
            }

            NavigationStack {
                KigoPulseLAView()
            }
            .tabItem {
                Label("Pulse LA", systemImage: "dot.radiowaves.left.and.right")
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
