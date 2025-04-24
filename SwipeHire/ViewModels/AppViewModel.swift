import SwiftUI

@MainActor
class AppViewModel: ObservableObject {
    @Published var jobService = JobDataService()
    @Published var profile: Profile = Profile()
    
    init() {
        loadProfile()
    }

    // Accessors
    var allJobs: [Job] {
        jobService.allJobs
    }

    var savedJobs: [Job] {
        jobService.savedJobs
    }

    // Actions
    func toggleSaved(for job: Job) {
        jobService.toggleSaved(job)
    }

    func isSaved(_ job: Job) -> Bool {
        jobService.isSaved(job)
    }
    
    private var profileURL: URL {
        FileManager.default.urls(for: .documentDirectory,
                                 in: .userDomainMask)[0]
          .appendingPathComponent("profile.json")
    }

    /// call once from init
    func loadProfile() {
        if let data = try? Data(contentsOf: profileURL),
           let decoded = try? JSONDecoder().decode(Profile.self, from: data) {
            profile = decoded
        }
    }

    /// one write API for app
    func updateProfile(_ p: Profile) {
        profile = p
        if let data = try? JSONEncoder().encode(p) {
            try? data.write(to: profileURL)
        }
    }
}
