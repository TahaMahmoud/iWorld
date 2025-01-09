//
//  LocationManager.swift
//  Core
//
//  Created by Taha Mahmoud on 09/01/2025.
//

import SwiftUI
import CoreLocation

public class LocationManager: NSObject, ObservableObject {
    public static let shared = LocationManager()

    private let locationManager = CLLocationManager()
    @Published public var authorisationStatus: CLAuthorizationStatus = .notDetermined

    public var currentLocation: CLLocation? {
        self.locationManager.location
    }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
    }

    public func requestAuthorisation(always: Bool = false) {
        if always {
            self.locationManager.requestAlwaysAuthorization()
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorisationStatus = status
    }
}
