import SwiftUI

struct AppTabView: View {
    var viewModel = AppViewModel()
    init() {
            let appearance = UITabBarAppearance()
        
            appearance.configureWithTransparentBackground()

            appearance.stackedLayoutAppearance.normal.iconColor = .lightGray

            appearance.stackedLayoutAppearance.selected.iconColor = .white
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    
    var body: some View {
        TabView {
            Tab("Profile", systemImage: "person.crop.circle.fill") {
                ProfileView(viewModel: viewModel)
                    .onAppear {
                              // ensure the location request fires
                              viewModel.locationManager.requestLocationIfNeeded(currentCity: viewModel.profile.city)
                            }
            }


            Tab("Home", systemImage: "house.fill") {
                HomeView(viewModel: viewModel)
            }


            Tab("Saved", systemImage: "tray.full.fill") {
                SavedJobsView(viewModel: viewModel)
            }
        }
        .foregroundColor(.white)
    }
}

#Preview {
    AppTabView()
}




