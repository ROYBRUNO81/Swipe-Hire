import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            Tab("Profile", systemImage: "person.crop.circle.fill") {
                ProfileView()
            }


            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }


            Tab("Saved", systemImage: "tray.full.fill") {
                SavedJobsView()
            }
        }
    }
}

#Preview {
    AppTabView()
}




