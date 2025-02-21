//
//  GeocodeManager.swift
//  iWorld
//
//  Created by Taha Mahmoud on 09/01/2025.
//

import Foundation
import CoreLocation
import MapKit

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country: String?, _ error: Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
