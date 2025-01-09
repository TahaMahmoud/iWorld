//
//  GetCurrentLocationUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Core
import CoreLocation
import Foundation

protocol GetCurrentLocationUseCaseProtocol {
    func execute() async throws -> LocationDetails
}

struct GetCurrentLocationUseCase: GetCurrentLocationUseCaseProtocol {
    func execute() async throws -> LocationDetails {
        guard
            LocationManager.shared.authorisationStatus != .authorizedWhenInUse ||
            LocationManager.shared.authorisationStatus != .authorizedAlways,
            let currentLocation = LocationManager.shared.currentLocation?.coordinate
        else { throw AppError.locationNotAvailable }

        let location = CLLocation(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude
        )

        var locationDetails = LocationDetails(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude
        )

        return try await withCheckedThrowingContinuation { continuation in
            location.fetchCityAndCountry { city, country, error in
                guard let city = city, let country = country, error == nil else { return }

                locationDetails.cityName = city
                locationDetails.countryName = country

                continuation.resume(returning: locationDetails)
            }
        }
    }
}
