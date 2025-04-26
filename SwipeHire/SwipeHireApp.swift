import SwiftUI

@main
struct SwipeHireApp: App {
    @StateObject private var viewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environmentObject(viewModel)
        }
    }
}
