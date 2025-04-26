import Foundation    

/// Core data model for a SwipeHire job card.
struct Job: Identifiable, Codable, Hashable, Equatable {

    // MARK: – Identity
    var id: String {
        [name.lowercased(), company.lowercased(), city.lowercased(), state.lowercased()]
                .map { $0.trimmingCharacters(in: .whitespaces) }
                .joined(separator: "|")
    }

    // MARK: – Display fields
    let name:        String
    let description: String
    let company:     String
    let imageName:   String
    let datePosted:  Foundation.Date
    let deadline:    Foundation.Date
    let skills:      [String]
    let city: String
    let state: String
    let country: String

    // MARK: – Per-user flags
    var isSaved:   Bool = false
    var isApplied: Bool = false

    // MARK: – CodingKeys (explicit → compiler never guesses)
    private enum CodingKeys: String, CodingKey {
        case name, description, company,
             imageName, datePosted, deadline,
             skills, isSaved, isApplied, city, state, country
    }
}
