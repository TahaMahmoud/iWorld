//
//  SaveCountryUseCaseTests.swift
//  iWorld
//
//  Created by Taha Mahmoud on 09/01/2025.
//


import Factory
@testable import iWorld
import XCTest

final class SaveCountryUseCaseTests: iWorldTestCase {

    fileprivate var countriesRepositoryMock: CountriesRepositoryMock!

    override func setUp() {
        super.setUp()
        countriesRepositoryMock = CountriesRepositoryMock()

        // Register the mock repository for dependency injection
        Container.shared.countriesRepo.register { self.countriesRepositoryMock }
    }

    func testSaveCountryWithValidCountryCode() -> Void {
        // Arrange
        let savedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington"),
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa")
        ]
        countriesRepositoryMock.savedCountries = savedCountries
        let useCase = SaveCountryUseCase()

        // Act
        useCase.execute(countryCode: "MEX")

        // Assert
        XCTAssertEqual(countriesRepositoryMock.savedCountries.count, 3)
        XCTAssertTrue(countriesRepositoryMock.savedCountries.contains { $0.alpha3Code == "MEX" })
    }

    func testSaveCountryWithExistingCountryCode() -> Void {
        // Arrange
        let savedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington"),
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa")
        ]
        countriesRepositoryMock.savedCountries = savedCountries
        let useCase = SaveCountryUseCase()

        // Act
        useCase.execute(countryCode: "USA")

        // Assert
        XCTAssertEqual(countriesRepositoryMock.savedCountries.count, 2)
    }

    func testSaveCountryWhenNoCountries() -> Void {
        // Arrange
        countriesRepositoryMock.savedCountries = []
        let useCase = SaveCountryUseCase()

        // Act
        useCase.execute(countryCode: "USA")

        // Assert
        XCTAssertEqual(countriesRepositoryMock.savedCountries.count, 1)
        XCTAssertTrue(countriesRepositoryMock.savedCountries.contains { $0.alpha3Code == "USA" })
    }
}
