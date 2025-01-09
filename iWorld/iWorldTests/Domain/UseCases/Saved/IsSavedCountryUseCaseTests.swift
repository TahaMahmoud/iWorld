//
//  IsSavedCountryUseCaseTests.swift
//  iWorld
//
//  Created by Taha Mahmoud on 09/01/2025.
//


import Factory
@testable import iWorld
import XCTest

final class IsSavedCountryUseCaseTests: iWorldTestCase {

    fileprivate var countriesRepositoryMock: CountriesRepositoryMock!

    override func setUp() {
        super.setUp()
        countriesRepositoryMock = CountriesRepositoryMock()

        // Register the mock repository for dependency injection
        Container.shared.countriesRepo.register { self.countriesRepositoryMock }
    }

    func testIsSavedCountryWithValidCode() -> Void {
        // Arrange
        let savedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington"),
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa")
        ]
        countriesRepositoryMock.savedCountries = savedCountries
        let useCase = IsSavedCountryUseCase()

        // Act
        let result = useCase.execute(countryCode: "USA")

        // Assert
        XCTAssertTrue(result)
    }

    func testIsSavedCountryWithInvalidCode() -> Void {
        // Arrange
        let savedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington"),
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa")
        ]
        countriesRepositoryMock.savedCountries = savedCountries
        let useCase = IsSavedCountryUseCase()

        // Act
        let result = useCase.execute(countryCode: "MEX")

        // Assert
        XCTAssertFalse(result)
    }

    func testIsSavedCountryWithEmptyCode() -> Void {
        // Arrange
        let savedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington"),
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa")
        ]
        countriesRepositoryMock.savedCountries = savedCountries
        let useCase = IsSavedCountryUseCase()

        // Act
        let result = useCase.execute(countryCode: "")

        // Assert
        XCTAssertFalse(result)
    }

    func testIsSavedCountryWhenNoSavedCountries() -> Void {
        // Arrange
        countriesRepositoryMock.savedCountries = []
        let useCase = IsSavedCountryUseCase()

        // Act
        let result = useCase.execute(countryCode: "USA")

        // Assert
        XCTAssertFalse(result)
    }
}
