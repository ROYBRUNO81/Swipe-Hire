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
        
        for saved in savedJobs {
            if let idx = allJobs.firstIndex(where: { $0.id == saved.id }) {
                allJobs[idx].isSaved   = saved.isSaved   
                allJobs[idx].isApplied = saved.isApplied
            }
        }
    }

    func saveJob(_ job: Job) {
       var j = job
       j.isSaved = true
       if let idxAll = allJobs.firstIndex(where: { $0.id == j.id }) {
           allJobs[idxAll].isSaved = true
       }
       if let idx = savedJobs.firstIndex(where: { $0.id == j.id }) {
           savedJobs[idx].isSaved   = true
           savedJobs[idx].isApplied = j.isApplied
       } else {
           savedJobs.append(j)
       }
       saveToDisk()
    }
    
    func applyJob(_ job: Job) {
       var j = job
       j.isSaved   = true
       j.isApplied = true
       // 1) mirror flags in allJobs
       if let idxAll = allJobs.firstIndex(where: { $0.id == j.id }) {
           allJobs[idxAll].isSaved   = true
           allJobs[idxAll].isApplied = true
       }
       // 2) then update savedJobs
       if let idx = savedJobs.firstIndex(where: { $0.id == j.id }) {
           savedJobs[idx] = j
       } else {
           savedJobs.append(j)
       }
       saveToDisk()
    }

    func unsaveJob(_ job: Job) {
        savedJobs.removeAll { $0.id == job.id }
        saveToDisk()
    }

    func toggleSaved(_ job: Job) {
        isSaved(job) ? unsaveJob(job) : saveJob(job)
    }

    func isSaved(_ job: Job) -> Bool {
        savedJobs.contains { $0.id == job.id }
    }
}
