import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: AppViewModel

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.05, green: 0.1, blue: 0.2),
                    Color(red: 0.1, green: 0.15, blue: 0.3)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Your Job Matches")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 60)

                Spacer()

                ZStack {
                    VStack {
                        Image(systemName: "exclamationmark.magnifyingglass")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(5)
                        
                        Text("No more matches")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .opacity(0.8)
                    
                    ForEach(viewModel.dummyJobs, id: \.self) { job in
                        CardView(job: job)
                    }
                    
                }

                Spacer(minLength: 60)
            }
            .padding(.horizontal)
        }
    }
}
