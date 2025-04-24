import Foundation    

/// Core data model for a SwipeHire job card.
struct Job: Identifiable, Codable, Hashable, Equatable {

    // MARK: – Identity
    let id: Foundation.UUID = .init()

    // MARK: – Display fields
    let name:        String
    let description: String
    let company:     String
    let imageName:   String
    let datePosted:  Foundation.Date
    let deadline:    Foundation.Date
    let fit:         Float
    let skills:      [String]

    // MARK: – Per-user flags
    var isSaved:   Bool = false
    var isApplied: Bool = false

    // MARK: – CodingKeys (explicit → compiler never guesses)
    private enum CodingKeys: String, CodingKey {
        case id, name, description, company,
             imageName, datePosted, deadline,
             fit, skills, isSaved, isApplied
    }
}
