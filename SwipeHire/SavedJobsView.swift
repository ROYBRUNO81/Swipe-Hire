import SwiftUI

struct SavedJobsView: View {
    @ObservedObject var viewModel: AppViewModel
    
    private var savedJobs: [Job] {
        var saved: [Job] = []
        for job in viewModel.dummyJobs {
            if job.status {
                saved.append(job)
            }
        }
        
        return saved
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    VStack {
                        Text("Saved Jobs")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        Text("\(savedJobs.count) opportunities")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 10)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.1, green: 0.15, blue: 0.3),
                                Color(red: 0.05, green: 0.1, blue: 0.2)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    
                    LazyVStack(spacing: 16) {
                        ForEach(savedJobs) { job in
                            SavedJobCard(job: job)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.05, green: 0.1, blue: 0.2),
                        Color(red: 0.1, green: 0.15, blue: 0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .navigationBarHidden(true)
        }
    }
}


struct SavedJobCard: View {
    let job: Job
    
    var body: some View {
        HStack(spacing: 16) {
 
            job.image
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .padding(12)
                .background(
                    Circle()
                        .fill(Color(red: 0.1, green: 0.15, blue: 0.3))
                )
                .overlay(
                    Circle()
                        .stroke(Color.blue.opacity(0.5), lineWidth: 1)
                )
            

            VStack(alignment: .leading, spacing: 4) {
                Text(job.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text(job.company)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            

            ZStack {
                Circle()
                    .trim(from: 0, to: CGFloat(job.fit))
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue, .purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: 5, lineCap: .round)
                    )
                    .rotationEffect(Angle(degrees: -90))
                    .frame(width: 50, height: 50)
                
                Text("\(Int(job.fit * 100))%")
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


extension Job: Identifiable {
    var id: String {
        return "\(name)_\(company)"
    }
}
