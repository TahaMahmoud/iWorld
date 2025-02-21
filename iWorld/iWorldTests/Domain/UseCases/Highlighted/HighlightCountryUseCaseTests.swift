//
//  HighlightCountryUseCaseTests.swift
//  iWorldTests
//
//  Created by Taha Mahmoud on 09/01/2025.
//

import Factory
@testable import iWorld
import XCTest

final class HighlightCountryUseCaseTests: iWorldTestCase {
    fileprivate var countriesRepositoryMock: CountriesRepositoryMock!

    override func setUp() {
        super.setUp()
        countriesRepositoryMock = CountriesRepositoryMock()
        Container.shared.countriesRepo.register { self.countriesRepositoryMock }
    }

    func testHighlightCountrySuccessfully() throws {
        // Arrange
        let countryCode = "EGY"
        countriesRepositoryMock.highlightedCountries = []

        // Act
        let highlightCountryUseCase = HighlightCountryUseCase()
        try highlightCountryUseCase.execute(countryCode: countryCode)

        // Assert
        XCTAssertEqual(countriesRepositoryMock.highlightedCountries.count, 1)
        XCTAssertEqual(countriesRepositoryMock.highlightedCountries.first?.alpha3Code, countryCode)
    }

    func testHighlightCountryThrowsWhenLimitExceeded() throws {
        // Arrange
        let countryCode = "EGY"
        countriesRepositoryMock.highlightedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington"),
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa"),
            Country(name: "Mexico", alpha3Code: "MEX", capital: "Mexico City"),
            Country(name: "Germany", alpha3Code: "GER", capital: "Berlin"),
            Country(name: "France", alpha3Code: "FRA", capital: "Paris")
        ]

        // Act & Assert
        let highlightCountryUseCase = HighlightCountryUseCase()
        XCTAssertThrowsError(try highlightCountryUseCase.execute(countryCode: countryCode)) { error in
            XCTAssertEqual(error as? AppError, AppError.highlightsLimitExceeded)
        }
    }

    func testHighlightCountryWhenNotExceedingLimit() throws {
        // Arrange
        let countryCode = "EGY"
        countriesRepositoryMock.highlightedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington"),
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa")
        ]

        // Act
        let highlightCountryUseCase = HighlightCountryUseCase()
        try highlightCountryUseCase.execute(countryCode: countryCode)

        // Assert
        XCTAssertEqual(countriesRepositoryMock.highlightedCountries.count, 3)
        XCTAssertEqual(countriesRepositoryMock.highlightedCountries.last?.alpha3Code, countryCode)
    }
}
