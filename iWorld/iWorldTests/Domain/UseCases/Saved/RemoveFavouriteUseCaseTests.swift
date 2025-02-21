//
//  RemoveFavouriteUseCaseTests.swift
//  iWorld
//
//  Created by Taha Mahmoud on 09/01/2025.
//

import Factory
@testable import iWorld
import XCTest

final class RemoveFavouriteUseCaseTests: iWorldTestCase {
    fileprivate var countriesRepositoryMock: CountriesRepositoryMock!

    override func setUp() {
        super.setUp()
        countriesRepositoryMock = CountriesRepositoryMock()

        // Register the mock repository for dependency injection
        Container.shared.countriesRepo.register { self.countriesRepositoryMock }
    }

    func testRemoveFavouriteWithValidCountryCode() {
        // Arrange
        let savedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington"),
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa"),
        ]
        countriesRepositoryMock.savedCountries = savedCountries
        let useCase = RemoveFavouriteUseCase()

        // Act
        useCase.execute(countryCode: "USA")

        // Assert
        XCTAssertEqual(countriesRepositoryMock.savedCountries.count, 1)
        XCTAssertFalse(countriesRepositoryMock.savedCountries.contains { $0.alpha3Code == "USA" })
    }

    func testRemoveFavouriteWithInvalidCountryCode() {
        // Arrange
        let savedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington"),
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa"),
        ]
        countriesRepositoryMock.savedCountries = savedCountries
        let useCase = RemoveFavouriteUseCase()

        // Act
        useCase.execute(countryCode: "MEX")

        // Assert
        XCTAssertEqual(countriesRepositoryMock.savedCountries.count, 2) // No changes since the code doesn't exist
    }

    func testRemoveFavouriteWhenNoSavedCountries() {
        // Arrange
        countriesRepositoryMock.savedCountries = []
        let useCase = RemoveFavouriteUseCase()

        // Act
        useCase.execute(countryCode: "USA")

        // Assert
        XCTAssertEqual(countriesRepositoryMock.savedCountries.count, 0) // No changes since there are no saved countries
    }
}
