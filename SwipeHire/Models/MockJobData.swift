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
        ),
        Job(
            name: "Android Developer",
            description: "Build and optimize Android applications.",
            company: "ByteStream",
            imageName: "android",
            datePosted: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            deadline: Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
            skills: ["kotlin", "android", "restapi"],
            city: "Seattle",
            state: "Washington",
            country: "United States"
        ),
        Job(
            name: "Backend Engineer",
            description: "Design and implement scalable server-side logic.",
            company: "DataFusion",
            imageName: "server.rack",
            datePosted: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
            deadline: Calendar.current.date(byAdding: .day, value: 21, to: Date())!,
            skills: ["nodejs", "postgres", "docker"],
            city: "Austin",
            state: "Texas",
            country: "United States"
        ),
        Job(
            name: "Frontend Developer",
            description: "Create responsive web interfaces.",
            company: "WebCraft",
            imageName: "globe",
            datePosted: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
            deadline: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
            skills: ["react", "typescript", "css"],
            city: "San Francisco",
            state: "California",
            country: "United States"
        ),
        Job(
            name: "DevOps Engineer",
            description: "Automate infrastructure and CI/CD pipelines.",
            company: "CloudSync",
            imageName: "cloud",
            datePosted: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
            deadline: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
            skills: ["aws", "terraform", "ci/cd"],
            city: "Denver",
            state: "Colorado",
            country: "United States"
        ),
        Job(
            name: "Product Manager",
            description: "Lead product strategy and roadmaps.",
            company: "InnovateX",
            imageName: "slider.horizontal.3",
            datePosted: Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
            deadline: Calendar.current.date(byAdding: .day, value: 20, to: Date())!,
            skills: ["roadmapping", "agile", "userresearch"],
            city: "Boston",
            state: "Massachusetts",
            country: "United States"
        ),
        Job(
            name: "QA Engineer",
            description: "Develop and maintain automated test suites.",
            company: "TestWorks",
            imageName: "checkmark.shield",
            datePosted: Calendar.current.date(byAdding: .day, value: -4, to: Date())!,
            deadline: Calendar.current.date(byAdding: .day, value: 25, to: Date())!,
            skills: ["selenium", "python", "automation"],
            city: "Chicago",
            state: "Illinois",
            country: "United States"
        ),
        Job(
            name: "Machine Learning Engineer",
            description: "Build and deploy ML models at scale.",
            company: "NeuralNet",
            imageName: "brain.head.profile",
            datePosted: Calendar.current.date(byAdding: .day, value: -6, to: Date())!,
            deadline: Calendar.current.date(byAdding: .day, value: 28, to: Date())!,
            skills: ["python", "pytorch", "tensorflow"],
            city: "New York",
            state: "New York",
            country: "United States"
        )
    ]
}
