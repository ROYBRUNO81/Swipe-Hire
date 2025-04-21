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
    var skills: [Image] = [Image(systemName: "person.fill.questionmark")]
    var schools: [String] = ["Upenn"]
    var experiences: [String] = ["Senior Prompt Engineer"]
    var experienceDescriptions: [String] = ["Code this app for me"]
    
    mutating func addSkill(_ skill: Image) {
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


