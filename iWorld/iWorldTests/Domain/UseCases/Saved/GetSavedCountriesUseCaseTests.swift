//
//  GetSavedCountriesUseCaseTests.swift
//  iWorld
//
//  Created by Taha Mahmoud on 09/01/2025.
//


import Factory
@testable import iWorld
import XCTest

final class GetSavedCountriesUseCaseTests: iWorldTestCase {

    fileprivate var countriesRepositoryMock: CountriesRepositoryMock!

    override func setUp() {
        super.setUp()
        countriesRepositoryMock = CountriesRepositoryMock()

        // Register the mock repository for dependency injection
        Container.shared.countriesRepo.register { self.countriesRepositoryMock }
    }

    func testGetSavedCountriesWithLimit() -> Void {
        // Arrange
        let savedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington"),
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa"),
            Country(name: "Mexico", alpha3Code: "MEX", capital: "Mexico City")
        ]
        countriesRepositoryMock.savedCountries = savedCountries
        let useCase = GetSavedCountriesUseCase()

        // Act
        let result = useCase.execute(limit: 2)

        // Assert
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].alpha3Code, "USA")
        XCTAssertEqual(result[1].alpha3Code, "CAN")
    }

    func testGetSavedCountriesWithoutLimit() -> Void {
        // Arrange
        let savedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington"),
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa"),
            Country(name: "Mexico", alpha3Code: "MEX", capital: "Mexico City")
        ]
        countriesRepositoryMock.savedCountries = savedCountries
        let useCase = GetSavedCountriesUseCase()

        // Act
        let result = useCase.execute(limit: nil)

        // Assert
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0].alpha3Code, "USA")
        XCTAssertEqual(result[1].alpha3Code, "CAN")
        XCTAssertEqual(result[2].alpha3Code, "MEX")
    }

    func testGetSavedCountriesWhenEmpty() -> Void {
        // Arrange
        countriesRepositoryMock.savedCountries = []
        let useCase = GetSavedCountriesUseCase()

        // Act
        let result = useCase.execute(limit: 2)

        // Assert
        XCTAssertTrue(result.isEmpty)
    }
}
