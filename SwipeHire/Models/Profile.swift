import Foundation
import SwiftUI
import CoreLocation

struct Profile {
    var firstName: String = "John"
    var lastName: String = "Doe"
    var about: String = "Hello World"
    var email: String = "gmail.com"
    var profileImage: Image = Image(systemName: "person.fill")
    var bannerImage: Image = Image("banner")
    var skills: [String] = []
    var schools: [String] = ["Upenn"]
    var experiences: [String] = ["Senior Prompt Engineer"]
    var experienceDescriptions: [String] = ["Code this app for me"]
    var city: String = ""
    var state: String = ""
    var country: String = ""
    
    mutating func addSkill(_ skill: String) {
        skills.append(skill)
    }
    
    mutating func addSchool(_ school: String) {
        schools.append(school)
    }
    
    mutating func addExperience(experience: String, experienceDescription: String) {
        experiences.append(experience)
        experienceDescriptions.append(experienceDescription)
    }
    
    mutating func removeSkill(at index: Int) {
        skills.remove(at: index)
    }
    
    mutating func removeSchool(at index: Int) {
        schools.remove(at: index)
    }
    
    mutating func removeExperience(at index: Int) {
        experiences.remove(at: index)
        experienceDescriptions.remove(at: index)
    }
    
    mutating func editName(first: String, last: String) {
        firstName = first
        lastName = last
    }
    
    mutating func editAbout(_ about: String) {
        self.about = about
    }
    
    mutating func editEmail(_ email: String) {
        self.email = email
    }
    
    mutating func editImage(_ image: Image){
        profileImage = image
    }
    
    mutating func editBannerImage(_ image: Image){
        bannerImage = image
    }
    

}

extension Profile: Codable {

    enum CodingKeys: String, CodingKey {
        case firstName, lastName, about, email, skills,
             schools, experiences, experienceDescriptions
        case city, state, country
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)

        // strings
        firstName  = try c.decode(String.self , forKey: .firstName)
        lastName   = try c.decode(String.self , forKey: .lastName)
        about      = try c.decode(String.self , forKey: .about)
        email      = try c.decode(String.self , forKey: .email)

        // arrays of strings
        schools               = try c.decode([String].self , forKey: .schools)
        experiences           = try c.decode([String].self , forKey: .experiences)
        experienceDescriptions = try c.decode([String].self , forKey: .experienceDescriptions)

        // images
        profileImage = Image(systemName: "person.fill")
        bannerImage  = Image("banner")
        skills     = try c.decodeIfPresent([String].self, forKey: .skills) ?? []
        
        // location
        city    = try c.decodeIfPresent(String.self, forKey: .city) ?? ""
        state   = try c.decodeIfPresent(String.self, forKey: .state) ?? ""
        country = try c.decodeIfPresent(String.self, forKey: .country) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)

        try c.encode(firstName , forKey: .firstName)
        try c.encode(lastName  , forKey: .lastName)
        try c.encode(about     , forKey: .about)
        try c.encode(email     , forKey: .email)
        try c.encode(skills,    forKey: .skills)

        try c.encode(schools              , forKey: .schools)
        try c.encode(experiences          , forKey: .experiences)
        try c.encode(experienceDescriptions, forKey: .experienceDescriptions)
        
        try c.encode(city,    forKey: .city)
        try c.encode(state,   forKey: .state)
        try c.encode(country, forKey: .country)
    }
}
