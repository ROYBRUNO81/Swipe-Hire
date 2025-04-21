import SwiftUI

struct CardView: View {
    var job: Job
    @State private var offset = CGSize.zero
    @State private var color = Color(red: 0.1, green: 0.2, blue: 0.4)

    var body: some View {
        ZStack {

            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [color, color.opacity(0.7)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 350, height: 600)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            
            VStack(alignment: .leading, spacing: 25) {
                HStack {
                    VStack(alignment: .leading, spacing: 5 ){
                        Text(job.name)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(job.company)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white.opacity(0.85))
                    }
                    Spacer()
                    
                    job.image
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                        .padding(12)
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.2))
                        )
                    
                    
                    
                }
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.vertical, 5)


                Text("Description")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white.opacity(0.8))

                Text(job.description)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .lineSpacing(4)


                VStack(alignment: .leading, spacing: 8) {
                    Text("Skills Required")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white.opacity(0.8))

                    HStack(spacing: 12) {
                        ForEach(0..<job.skills.count, id: \.self) { index in
                            job.skills[index]
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white.opacity(0.15))
                                )
                        }
                    }
                }

                //Dates
                VStack(alignment: .leading, spacing: 12) {
                    DateInfoRow(label: "Posted", date: job.datePosted)
                    DateInfoRow(label: "Deadline", date: job.deadine)
                }

                //Match % bar
                VStack(alignment: .leading, spacing: 8) {
                    Text("Match")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white.opacity(0.8))

                    HStack {
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .frame(width: geometry.size.width, height: 10)
                                    .opacity(0.3)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)

                                Rectangle()
                                    .frame(width: geometry.size.width * CGFloat(job.fit), height: 10)
                                    .foregroundColor(fitColor(for: Double(job.fit)))
                                    .cornerRadius(5)
                            }
                        }
                        .frame(height: 10)

                        Text("\(Int(job.fit * 100))%")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }
                }

                Button(action: {
                    //TODO: Add navigation to jobdetail
                }) {
                    Text("Apply Now")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(color)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                        )
                }
                .padding(.top, 10)
            }
            .padding(25)
            .frame(width: 350, height: 600)
        }
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width/25)))
        .gesture(
            DragGesture()
                .onChanged{
                    gesture in offset = gesture.translation
                    withAnimation {
                        changeColor(width: offset.width)
                    }
                }
                .onEnded{ _ in
                    withAnimation{
                        swipe(width: offset.width)
                    }
                    withAnimation {
                        changeColor(width: offset.width)
                    }
                })
    }
    
    private func swipe(width: CGFloat){
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
        case 150...500:
            offset = CGSize(width: 500, height: 0)
            
        default:
            offset = .zero
        }
    }
    
    private func changeColor(width: CGFloat){
        switch width {
        case -500...(-120):
            color = .red
        case 120...500:
            color = .green
        default:
            color = Color(red: 0.1, green: 0.2, blue: 0.4)
        }
    }
    
    private func fitColor(for fit: Double) -> Color {
        if fit >= 0.7 {
            return Color.green
        } else if fit >= 0.5 {
            return Color.yellow
        } else {
            return Color.orange
        }
    }
}

struct DateInfoRow: View {
    var label: String
    var date: Date
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
            
            Spacer()
            
            Text(formattedDate(date))
                .font(.system(size: 16))
                .foregroundColor(.white)
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    CardView(job: Job(
        name: "iOS Developer",
        description: "Develop and maintain iOS applications using Swift and SwiftUI.",
        company: "TechNova Inc.",
        image: Image(systemName: "iphone"),
        datePosted: Date(),
        deadine: Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
        fit: 0.7,
        skills: [
            Image(systemName: "swift"),
            Image(systemName: "hammer.fill"),
            Image(systemName: "rectangle.3.offgrid.bubble.left")
        ]
    ))
}
