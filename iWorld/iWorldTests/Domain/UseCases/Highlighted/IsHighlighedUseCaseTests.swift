//
//  IsHighlighedUseCaseTests.swift
//  iWorld
//
//  Created by Taha Mahmoud on 09/01/2025.
//


import Factory
@testable import iWorld
import XCTest

final class IsHighlighedUseCaseTests: iWorldTestCase {
    fileprivate var countriesRepositoryMock: CountriesRepositoryMock!

    override func setUp() {
        super.setUp()
        countriesRepositoryMock = CountriesRepositoryMock()
        Container.shared.countriesRepo.register { self.countriesRepositoryMock }
    }

    func testIsCountryHighlightedReturnsTrue() -> Void {
        // Arrange
        let countryCode = "USA"
        countriesRepositoryMock.highlightedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington")
        ]

        // Act
        let isHighlighedUseCase = IsHighlighedUseCase()
        let isHighlighted = isHighlighedUseCase.execute(countryCode: countryCode)

        // Assert
        XCTAssertTrue(isHighlighted)
    }

    func testIsCountryHighlightedReturnsFalseWhenNotHighlighted() -> Void {
        // Arrange
        let countryCode = "USA"
        countriesRepositoryMock.highlightedCountries = [
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa")
        ]

        // Act
        let isHighlighedUseCase = IsHighlighedUseCase()
        let isHighlighted = isHighlighedUseCase.execute(countryCode: countryCode)

        // Assert
        XCTAssertFalse(isHighlighted)
    }

    func testIsCountryHighlightedReturnsFalseForEmptyCode() -> Void {
        // Arrange
        let countryCode = ""
        countriesRepositoryMock.highlightedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington")
        ]

        // Act
        let isHighlighedUseCase = IsHighlighedUseCase()
        let isHighlighted = isHighlighedUseCase.execute(countryCode: countryCode)

        // Assert
        XCTAssertFalse(isHighlighted)
    }
}
