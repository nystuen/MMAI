import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            UpcomingEventsView()
                .tabItem {
                    Image(systemName: "calendar")
                        .frame(height: 80)
                    Text("Events")
                }
            CompletedEventsView()
                .tabItem {
                    Image(systemName: "calendar")
                        .frame(height: 80)
                    Text("Completed Events")
                }
            AthleteMatchupView(match: nil)
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Compare")
                }
            AthleteView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Libary")
                }
        }
        .tint(.theme.red)
        .background(Color.theme.background)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color.theme.background.opacity(0.8))
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
