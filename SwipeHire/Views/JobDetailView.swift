import SwiftUI

/// Full-screen detail page for a single Job.
struct JobDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: AppViewModel
    @State private var job: Job
    
    init(viewModel: AppViewModel, job: Job) {
        self.viewModel = viewModel
        _job = State(initialValue: job)
    }

    // ───────────────────────────────────────────────────────────── MARK: Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                header

                Text(job.description)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineSpacing(4)

                skillsSection
                datesSection
                matchSection

                applyButton
            }
            .padding(24)
        }
        .background(
            LinearGradient(
                colors: [Color(red: 0.05, green: 0.10, blue: 0.20),
                         Color(red: 0.10, green: 0.15, blue: 0.30)],
                startPoint: .topLeading,
                endPoint:   .bottomTrailing
            )
            .ignoresSafeArea()
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.jobService.toggleSaved(job)
                    job.isSaved.toggle()
                } label: {
                    Image(systemName: job.isSaved ? "bookmark.fill"
                                                  : "bookmark")
                        .foregroundColor(.yellow)
                }
            }
        }
    }

    // ───────────────────────────────────────────────────────── header
    private var header: some View {
        HStack(alignment: .top) {
            Image(systemName: job.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 4) {
                Text(job.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(job.company)
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
            }
            Spacer()
        }
    }

    // ───────────────────────────────────────────────────────── skills
    private var skillsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Required skills")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))

            HStack(spacing: 12) {
                ForEach(job.skills, id: \.self) { symbol in
                    Image(systemName: symbol)
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white.opacity(0.15))
                        )
                }
            }
        }
    }

    // ───────────────────────────────────────────────────────── dates
    private var datesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            DateInfoRow(label: "Posted",   date: job.datePosted)
            DateInfoRow(label: "Deadline", date: job.deadline)
        }
    }

    // ───────────────────────────────────────────────────────── match
    private var matchSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Match")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))

            HStack {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 10)
                        Capsule()
                            .fill(fitColor(for: job.fit))
                            .frame(width: geo.size.width * CGFloat(job.fit),
                                   height: 10)
                    }
                }
                .frame(height: 10)

                Text("\(Int(job.fit * 100))%")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }

    private var applyButton: some View {
        Button {
            job.isApplied = true
            viewModel.jobService.saveJob(job)   // or custom apply logic
            dismiss()
        } label: {
            Text(job.isApplied ? "Applied" : "Apply Now")
                .font(.headline)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                )
        }
        .disabled(job.isApplied)
        .opacity(job.isApplied ? 0.6 : 1)
    }

    private func fitColor(for fit: Float) -> Color {
        switch fit {
        case 0.7...:   return .green
        case 0.5...:   return .yellow
        default:       return .orange
        }
    }
}

#Preview {
    NavigationView {
        JobDetailView(
            viewModel: AppViewModel(),
            job: Job(
                name:        "iOS Developer",
                description: "Build and maintain iOS applications.",
                company:     "TechNova",
                imageName:   "iphone",
                datePosted:  Date(),
                deadline:    Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
                fit:         0.8,
                skills:      ["swift", "hammer.fill", "rectangle.3.offgrid.bubble.left"]
            )
        )
    }
}

