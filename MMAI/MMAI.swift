import SwiftUI

@main
struct MMAI: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TabBar()
                   .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
}
