import Foundation
import CoreLocation
import Combine

@MainActor
class LocationManager: NSObject, ObservableObject {
    @Published var city: String = ""
    @Published var state: String = ""
    @Published var country: String = ""

    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()

    /// Map US postal abbreviations → full state names
    private let stateNameMap: [String:String] = [
        "AL":"Alabama","AK":"Alaska","AZ":"Arizona","AR":"Arkansas","CA":"California",
        "CO":"Colorado","CT":"Connecticut","DE":"Delaware","FL":"Florida","GA":"Georgia",
        "HI":"Hawaii","ID":"Idaho","IL":"Illinois","IN":"Indiana","IA":"Iowa",
        "KS":"Kansas","KY":"Kentucky","LA":"Louisiana","ME":"Maine","MD":"Maryland",
        "MA":"Massachusetts","MI":"Michigan","MN":"Minnesota","MS":"Mississippi","MO":"Missouri",
        "MT":"Montana","NE":"Nebraska","NV":"Nevada","NH":"New Hampshire","NJ":"New Jersey",
        "NM":"New Mexico","NY":"New York","NC":"North Carolina","ND":"North Dakota","OH":"Ohio",
        "OK":"Oklahoma","OR":"Oregon","PA":"Pennsylvania","RI":"Rhode Island","SC":"South Carolina",
        "SD":"South Dakota","TN":"Tennessee","TX":"Texas","UT":"Utah","VT":"Vermont",
        "VA":"Virginia","WA":"Washington","WV":"West Virginia","WI":"Wisconsin","WY":"Wyoming"
    ]

    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocationIfNeeded(currentCity: String) {
        guard currentCity.isEmpty else { return }
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    nonisolated func locationManager(
      _ manager: CLLocationManager,
      didChangeAuthorization status: CLAuthorizationStatus
    ) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.requestLocation()
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locs: [CLLocation]) {
        guard let loc = locs.first else { return }
        geocoder.reverseGeocodeLocation(loc) { places, _ in
            guard let place = places?.first else { return }

            // Pull out the raw code
            let rawCity  = place.locality    ?? ""
            let rawState = place.administrativeArea ?? ""
            let rawCountry = place.country  ?? ""
            
            // Look up full state name (fallback to code if unknown)
            let fullState = self.stateNameMap[rawState] ?? rawState

            Task { @MainActor in
                self.city    = rawCity
                self.state   = fullState
                self.country = rawCountry
            }
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error:", error)
    }
}
