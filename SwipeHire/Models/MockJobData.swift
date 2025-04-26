import Foundation

/// Local placeholder data shown on first launch.
struct MockJobData {
    static let sampleJobs: [Job] = [
        Job(
            name: "iOS Developer",
            description: "Develop and maintain iOS apps with SwiftUI.",
            company: "TechNova",
            imageName: "iphone",
            datePosted: Date(),
            deadline: Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
            skills: ["swift", "combine", "uikit"],
            city: "San Diego",
            state: "California",
            country: "United States"
        ),
        Job(
            name: "UX Designer",
            description: "Design elegant and accessible interfaces.",
            company: "PixelPushers",
            imageName: "paintbrush",
            datePosted: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
            deadline: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
            skills: ["figma", "sketch", "prototyping"],
            city: "Pittsburgh",
            state: "Pennsylvania",
            country: "United States"
        ),
        Job(
            name: "Data Scientist",
            description: "Build ML models and surface insights.",
            company: "DataWave Labs",
            imageName: "brain.head.profile",
            datePosted: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
            deadline: Calendar.current.date(byAdding: .day, value: 20, to: Date())!,
            skills: ["python", "pandas", "tensorflow"],
            city: "Philadelphia",
            state: "Pennsylvania",
            country: "United States"
        )
    ]
}
