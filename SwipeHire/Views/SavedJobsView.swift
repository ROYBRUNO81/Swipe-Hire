import SwiftUI

struct SavedJobsView: View {
  @EnvironmentObject var viewModel: AppViewModel

    private var savedOnly:   [Job] { viewModel.jobService.savedJobs.filter { !$0.isApplied } }
    private var appliedOnly: [Job] { viewModel.jobService.savedJobs.filter { $0.isApplied } }

    var body: some View {
        NavigationStack {
            ZStack {
                // ─── Usual gradient background ────────────────────────────
                LinearGradient(
                    colors: [
                        Color(red: 0.05, green: 0.10, blue: 0.20),
                        Color(red: 0.10, green: 0.15, blue: 0.30)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                // ─── If there are no saved/applied jobs, just show background (optionally placeholder) ───
                if savedOnly.isEmpty && appliedOnly.isEmpty {
                    VStack {
                        Image(systemName: "bookmark.slash")
                            .font(.largeTitle)
                            .foregroundColor(.white.opacity(0.5))
                            .padding(.bottom, 8)
                        Text("No saved or applied jobs")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                // ─── Otherwise render your Saved & Applied sections ────────────────────────────────────
                else {
                    ScrollView {
                        VStack(spacing: 24) {
                            // Saved Jobs
                            if !savedOnly.isEmpty {
                                Text("Saved Jobs")
                                    .font(.largeTitle).bold()
                                    .foregroundColor(.white)
                                    .padding(.horizontal)

                                LazyVStack(spacing: 16) {
                                    ForEach(savedOnly) { job in
                                        HStack {
                                            NavigationLink {
                                                JobDetailView(viewModel: viewModel, job: job)
                                            } label: {
                                                SavedJobCard(job: job, viewModel: viewModel)
                                            }
                                            Spacer()
                                            Button {
                                                viewModel.toggleSaved(job)
                                            } label: {
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }

                            // Applied Jobs
                            if !appliedOnly.isEmpty {
                                Text("Applied Jobs")
                                    .font(.largeTitle).bold()
                                    .foregroundColor(.white)
                                    .padding(.horizontal)

                                LazyVStack(spacing: 16) {
                                    ForEach(appliedOnly) { job in
                                        NavigationLink {
                                            JobDetailView(viewModel: viewModel, job: job)
                                        } label: {
                                            SavedJobCard(job: job, viewModel: viewModel)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 20)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}


struct SavedJobCard: View {
    let job: Job
    @ObservedObject var viewModel: AppViewModel

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: job.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .padding(12)
                .background(
                    Circle().fill(Color(red: 0.1, green: 0.15, blue: 0.3))
                )
                .overlay(
                    Circle().stroke(Color.blue.opacity(0.5), lineWidth: 1)
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(job.name)
                    .font(.headline).fontWeight(.semibold)
                    .foregroundColor(.white)

                Text(job.company)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
            let f = viewModel.fit(for: job)

            ZStack {
                Circle()
                    .trim(from: 0, to: CGFloat(f))
                    .stroke(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: 5, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .frame(width: 50, height: 50)

                Text("\(Int(f * 100))%")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.2))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.blue.opacity(0.2), lineWidth: 1)
        )
    }
}
