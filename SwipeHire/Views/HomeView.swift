import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = AppViewModel()
    @State private var selected: Job?  

    var body: some View {
        NavigationStack {
            ZStack{
                background
                
                VStack(spacing: 0) {
                    // Search & filter controls above the cards
                    SearchView(viewModel: viewModel)
                        .padding(.vertical, 12)
                    ZStack {

                        // use filteredJobs instead of allJobs
                        ForEach(viewModel.filteredJobs) { job in
                            CardView(job: job)
                                .zIndex(Double(viewModel.fit(for: job)))
                                .onTapGesture {
                                    selected = job
                                }
                        }
                    }
                }
            }
            .navigationTitle("Your Job Match")
            .navigationDestination(item: $selected) { job in
                JobDetailView(viewModel: viewModel, job: job)
            }
        }
    }

    // MARK: – sub-views -------------------------------------------------------

    private var background: some View {
        LinearGradient(
            colors: [
                Color(red: 0.05, green: 0.10, blue: 0.20),
                Color(red: 0.10, green: 0.15, blue: 0.30)
            ],
            startPoint: .topLeading,
            endPoint:   .bottomTrailing
        )
        .ignoresSafeArea()
    }

    private var mainContent: some View {
        VStack(spacing: 20) {
            Spacer()

            ZStack {
                noMatchesView.opacity(viewModel.jobService.allJobs.isEmpty ? 1 : 0)

                // top card is last in the ForEach so it sits on top
                ForEach(viewModel.jobService.allJobs) { job in
                    NavigationLink {                       
                        JobDetailView(viewModel: viewModel, job: job)
                    } label: {
                        CardView(job: job)                   // swipe card
                    }
                }
            }

            Spacer(minLength: 60)
        }
        .padding(.horizontal)
    }

    private var noMatchesView: some View {
        VStack(spacing: 5) {
            Image(systemName: "exclamationmark.magnifyingglass")
                .font(.headline)
                .foregroundColor(.white)
            Text("No more matches")
                .font(.headline)
                .foregroundColor(.white)
        }
        .opacity(0.8)
    }
}
