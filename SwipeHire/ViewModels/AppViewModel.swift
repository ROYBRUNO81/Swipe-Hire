import SwiftUI
import Combine

@MainActor
class AppViewModel: ObservableObject {
    @Published var jobService = JobDataService()
    @Published var profile: Profile = Profile()
    @Published var filteredJobs: [Job] = []
    
    private var lastQuery     = ""
    private var lastStateOnly = false
    
    let locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadProfile()
        
        locationManager.requestLocationIfNeeded(currentCity: profile.city)
        applyFilters(query: "", stateOnly: false)
                
        // listen for updates and write them into profile + disk
        Publishers
          .CombineLatest3(
            locationManager.$city,
            locationManager.$state,
            locationManager.$country
          )
          .filter { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty }
          .sink { [weak self] city, state, country in
            guard let self = self else { return }
            self.profile.city    = city
            self.profile.state   = state
            self.profile.country = country
            self.saveProfile()
            self.applyFilters(query: "", stateOnly: false)
          }
          .store(in: &cancellables)

    }
    
    // Search query + location filter
    func applyFilters(query: String, stateOnly: Bool) {
        lastQuery     = query
        lastStateOnly = stateOnly
        let user = profile 
        // first filter by location
        let byLocation: [Job]
        if stateOnly {
            byLocation = jobService.allJobs.filter { $0.state.lowercased()   == user.state.lowercased() }
        } else {
            byLocation = jobService.allJobs.filter { $0.country.lowercased() == user.country.lowercased() }
        }

        // then filter by search query on job.name
        let afterSearch: [Job]
        if query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            afterSearch = byLocation
        } else {
            let lower = query.lowercased()
            afterSearch = byLocation.filter { $0.name.lowercased().contains(lower) }
        }
        
        // drop any saved or applied jobs
        filteredJobs = afterSearch.filter { !($0.isSaved || $0.isApplied) }
    }
    
    // Returns the fraction of this job’s skills that the user has.
    func fit(for job: Job) -> Float {
        guard !job.skills.isEmpty else { return 0 }
        let user = Set(profile.skills.map { $0.lowercased() })
        let need = Set(job.skills.map    { $0.lowercased() })
        let match = user.intersection(need).count
        return Float(match) / Float(job.skills.count)
    }

    // Accessors
    func save(_ job: Job) {
        jobService.saveJob(job)
        applyFilters(query: lastQuery, stateOnly: lastStateOnly)
    }

    func apply(_ job: Job) {
        jobService.applyJob(job)
        applyFilters(query: lastQuery, stateOnly: lastStateOnly)
    }

    func toggleSaved(_ job: Job) {
        jobService.toggleSaved(job)
        applyFilters(query: lastQuery, stateOnly: lastStateOnly)
    }
    
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
        saveProfile()
        applyFilters(query: lastQuery, stateOnly: lastStateOnly)
    }
    
    private func saveProfile() {
        if let data = try? JSONEncoder().encode(profile) {
            try? data.write(to: profileURL)
        }
    }
}
