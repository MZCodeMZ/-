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
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
