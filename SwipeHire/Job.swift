import Foundation
import SwiftUI
import CoreLocation

struct Job: Hashable{
    let name: String
    let description: String
    let company: String
    let image: Image
    let datePosted: Date
    let deadine: Date
    let fit: Float
    let skills: [Image]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}


