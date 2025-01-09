//
//  RemoveHighlightUseCaseTests.swift
//  iWorld
//
//  Created by Taha Mahmoud on 09/01/2025.
//

import Factory
@testable import iWorld
import XCTest

final class RemoveHighlightUseCaseTests: iWorldTestCase {
    fileprivate var countriesRepositoryMock: CountriesRepositoryMock!

    override func setUp() {
        super.setUp()
        countriesRepositoryMock = CountriesRepositoryMock()
        Container.shared.countriesRepo.register { self.countriesRepositoryMock }
    }

    func testRemoveHighlight() {
        // Arrange
        let countryCode = "USA"
        countriesRepositoryMock.highlightedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington"),
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa"),
        ]
        let removeHighlightUseCase = RemoveHighlightUseCase()

        // Act
        removeHighlightUseCase.execute(countryCode: countryCode)

        // Assert
        XCTAssertFalse(countriesRepositoryMock.highlightedCountries.contains { $0.alpha3Code == countryCode })
    }

    func testRemoveHighlightWhenCountryNotHighlighted() {
        // Arrange
        let countryCode = "USA"
        countriesRepositoryMock.highlightedCountries = [
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa"),
        ]
        let removeHighlightUseCase = RemoveHighlightUseCase()

        // Act
        removeHighlightUseCase.execute(countryCode: countryCode)

        // Assert
        XCTAssertEqual(countriesRepositoryMock.highlightedCountries.count, 1)
    }

    func testRemoveHighlightWhenHighlightedListIsEmpty() {
        // Arrange
        let countryCode = "USA"
        countriesRepositoryMock.highlightedCountries = []
        let removeHighlightUseCase = RemoveHighlightUseCase()

        // Act
        removeHighlightUseCase.execute(countryCode: countryCode)

        // Assert
        XCTAssertTrue(countriesRepositoryMock.highlightedCountries.isEmpty)
    }
}
