import SwiftUI

@Observable class AppViewModel: ObservableObject {
    let dummyJobs: [Job] = [
        Job(
            name: "iOS Developer",
            description: "Develop and maintain iOS applications using Swift and SwiftUI.",
            company: "TechNova Inc.",
            image: Image(systemName: "iphone"),
            datePosted: Date(),
            deadine: Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
            fit: 0.85,
            skills: [
                Image(systemName: "swift"),
                Image(systemName: "hammer.fill"),
                Image(systemName: "rectangle.3.offgrid.bubble.left")
            ]
        ),
        Job(
            name: "UX Designer",
            description: "Design beautiful and accessible user interfaces and experiences.",
            company: "PixelPushers",
            image: Image(systemName: "paintbrush"),
            datePosted: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            deadine: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
            fit: 0.78,
            skills: [
                Image(systemName: "scribble.variable"),
                Image(systemName: "eyeglasses"),
                Image(systemName: "hand.tap")
            ]
        ),
        Job(
            name: "Data Scientist",
            description: "Build predictive models and extract insights from large datasets.",
            company: "DataWave Labs",
            image: Image(systemName: "brain.head.profile"),
            datePosted: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
            deadine: Calendar.current.date(byAdding: .day, value: 20, to: Date())!,
            fit: 0.91,
            skills: [
                Image(systemName: "function"),
                Image(systemName: "chart.bar.doc.horizontal"),
                Image(systemName: "server.rack")
            ]
        ),
        Job(
            name: "Marketing Analyst",
            description: "Use data to improve campaign strategy and target audience segmentation.",
            company: "BrightBuzz",
            image: Image(systemName: "megaphone.fill"),
            datePosted: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
            deadine: Calendar.current.date(byAdding: .day, value: 12, to: Date())!,
            fit: 0.69,
            skills: [
                Image(systemName: "chart.pie.fill"),
                Image(systemName: "target"),
                Image(systemName: "bubble.left.and.bubble.right.fill")
            ]
        ),
        Job(
            name: "Project Manager",
            description: "Lead teams and manage timelines to deliver quality software projects.",
            company: "LaunchPoint",
            image: Image(systemName: "calendar.badge.clock"),
            datePosted: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
            deadine: Calendar.current.date(byAdding: .day, value: 25, to: Date())!,
            fit: 0.74,
            skills: [
                Image(systemName: "list.bullet.rectangle"),
                Image(systemName: "person.2.fill"),
                Image(systemName: "clock.arrow.circlepath")
            ]
        )
    ]
    
    var profile: Profile = Profile()

}
