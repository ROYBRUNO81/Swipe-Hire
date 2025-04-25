//
//  LocationManager.swift
//  SwipeHire
//
//  Created by Bruno Ndiba Mbwaye Roy on 4/24/25.
//

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

    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocationIfNeeded(currentCity: String) {
        // only ask once, if we don’t already have a city
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
            Task { @MainActor in
                self.city    = place.locality    ?? ""
                self.state   = place.administrativeArea ?? ""
                self.country = place.country     ?? ""
            }
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error:", error)
    }
}
