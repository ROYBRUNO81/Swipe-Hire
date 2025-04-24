import Foundation
import Combine

/// home feed + saved list
@MainActor
class JobDataService: ObservableObject {

    @Published var allJobs:   [Job] = []
    @Published var savedJobs: [Job] = []

    init() { loadJobs() }

    private var jobsURL: URL {
        FileManager.default.urls(for: .documentDirectory,
                                 in: .userDomainMask)[0]
            .appendingPathComponent("savedJobs.json")
    }

    private func saveToDisk() {
        do {
            try JSONEncoder().encode(savedJobs).write(to: jobsURL)
        } catch {
            print("Save failed:", error)
        }
    }

    private func loadJobs() {
        // Restore saved jobs if file exists
        if
            let data     = try? Data(contentsOf: jobsURL),
            let decoded  = try? JSONDecoder().decode([Job].self, from: data)
        {
            savedJobs = decoded
        }

        // populate home feed with mock job data (for now)
        allJobs = MockJobData.sampleJobs
    }

    func isSaved(_ job: Job) -> Bool {
        savedJobs.contains { $0.id == job.id }
    }

    func saveJob(_ job: Job) {
        guard !isSaved(job) else { return }
        savedJobs.append(job)
        saveToDisk()
    }

    func unsaveJob(_ job: Job) {
        savedJobs.removeAll { $0.id == job.id }
        saveToDisk()
    }

    func toggleSaved(_ job: Job) {
        isSaved(job) ? unsaveJob(job) : saveJob(job)
    }
}
