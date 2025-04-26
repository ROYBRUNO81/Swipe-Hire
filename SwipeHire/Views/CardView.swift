import SwiftUI

struct CardView: View {
    let job: Job
    @EnvironmentObject var viewModel: AppViewModel

    // compute fit on-the-fly
    private var fitValue: Float { viewModel.fit(for: job) }

    // swipe animation state
    @State private var offset = CGSize.zero
    @State private var color  = Color(red: 0.10, green: 0.20, blue: 0.40)

    var body: some View {
        ZStack {
            cardBackground
            cardContent
        }
        .frame(width: 350, height: 570)
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 25)))
        .gesture(
            DragGesture()
                .onChanged { g in
                    offset = g.translation
                    changeColor(for: offset.width)
                }
                .onEnded { _ in
                    // swipe right = save
                    if offset.width > 150 {
                      viewModel.save(job)
                    }
                    // add left-swipe logic here
                    swipe(for: offset.width)
                    changeColor(for: offset.width)
                }
        )
    }

    /// Gradient rounded-rectangle background
    private var cardBackground: some View {
        let gradient = Gradient(colors: [color, color.opacity(0.7)])

        return RoundedRectangle(cornerRadius: 20)
            .fill(
                LinearGradient(
                    gradient: gradient,
                    startPoint: .topLeading,
                    endPoint:   .bottomTrailing
                )
            )
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
    }

    /// Everything drawn on top of the background
    private var cardContent: some View {
        VStack(alignment: .leading, spacing: 25) {
            header
            Divider().background(Color.white.opacity(0.3))
            descriptionSection
            Text("\(job.city), \(job.state), \(job.country)")
              .font(.footnote)
              .foregroundColor(.white.opacity(0.7))
            skillsSection
            datesSection
            matchBarSection
            applyButton
        }
        .padding(25)
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(job.name)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)

                Text(job.company)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.85))
            }
            Spacer()
            Image(systemName: job.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .foregroundColor(.white)
        }
    }

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Description")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white.opacity(0.8))

            Text(job.description)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .lineSpacing(4)
        }
    }

    private var skillsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Skills Required")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white.opacity(0.8))

            FlowLayout(spacing: 8) {
                ForEach(job.skills, id: \.self) { skill in
                    Text(skill)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(8)
                }
            }
        }
    }

    private var datesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            DateInfoRow(label: "Posted",   date: job.datePosted)
            DateInfoRow(label: "Deadline", date: job.deadline)
        }
    }

    private var matchBarSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Match")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white.opacity(0.8))

            HStack {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 10)

                        Capsule()
                            .fill(fitColor(for: fitValue))
                            .frame(width: geo.size.width * CGFloat(fitValue),
                                   height: 10)
                    }
                }
                .frame(height: 10)

                Text("\(Int(fitValue * 100))%")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
        }
    }

    private var applyButton: some View {
        Button {
            viewModel.apply(job)
        } label: {
            Text(job.isApplied ? "Applied" : "Apply Now")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(color)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                )
        }
        .disabled(job.isApplied)
        .opacity(job.isApplied ? 0.6 : 1)
        .padding(.top, 10)
    }


    private func swipe(for width: CGFloat) {
        switch width {
        case ..<(-150):  offset = .init(width: -500, height: 0)
        case 150...:     offset = .init(width:  500, height: 0)
        default:         offset = .zero
        }
    }

    private func changeColor(for width: CGFloat) {
        switch width {
        case ..<(-120):  color = .red
        case 120...:     color = .green
        default:         color = Color(red: 0.10, green: 0.20, blue: 0.40)
        }
    }

    private func fitColor(for fit: Float) -> Color {
        switch fit {
        case 0.7...:   return .green
        case 0.5...:   return .yellow
        default:       return .orange
        }
    }
}


struct DateInfoRow: View {
    let label: String
    let date:  Date

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
            Spacer()
            Text(date, format: .dateTime.month(.abbreviated).day().year())
                .font(.system(size: 16))
                .foregroundColor(.white)
        }
    }
}

// MARK: - Preview -------------------------------------------------------------

#Preview {
    CardView(job: Job(
        name:        "iOS Developer",
        description: "Build amazing iOS apps with SwiftUI.",
        company:     "TechNova",
        imageName:   "iphone",
        datePosted:  Date(),
        deadline:    Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
        skills:      ["swift", "Java"],
        city: "Pittsburgh",
        state: "Pennsylvania",
        country: "United States"
    ))
    .environmentObject(AppViewModel())
}
