import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(viewModel.dummyJobs, id: \.self) {
                    job in CardView(job: job)
                }
            }
        }
    }
}
