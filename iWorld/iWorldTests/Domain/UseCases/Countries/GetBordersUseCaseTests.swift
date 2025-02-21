//
//  GetBordersUseCaseTests.swift
//  iWorldTests
//
//  Created by Taha Mahmoud on 09/01/2025.
//

import XCTest
import Factory
@testable import iWorld

final class GetBordersUseCaseTests: iWorldTestCase {
    
    fileprivate var countriesRepositoryMock: CountriesRepositoryMock!
    
    override func setUp() {
        super.setUp()
        countriesRepositoryMock = CountriesRepositoryMock()
        Container.shared.countriesRepo.register { self.countriesRepositoryMock }
    }
    
    func testGetBordersWithValidCountry() {
        // Arrange
        let country = Country(name: "United States", alpha3Code: "USA", borders: ["CAN", "MEX"])
        let canada = Country(name: "Canada", alpha3Code: "CAN", borders: [])
        let mexico = Country(name: "Mexico", alpha3Code: "MEX", borders: [])
        
        countriesRepositoryMock = CountriesRepositoryMock(countries: [country, canada, mexico])
        
        let useCase = GetBordersUseCase()

        // Act
        let borders = useCase.execute(countryCode: "USA")

        // Assert
        XCTAssertEqual(borders.count, 2)
        XCTAssertTrue(borders.contains { $0.alpha3Code == "CAN" })
        XCTAssertTrue(borders.contains { $0.alpha3Code == "MEX" })
    }

    func testGetBordersWithNoBorders() {
        // Arrange
        let country = Country(name: "Iceland", alpha3Code: "ISL", borders: [])
        
        countriesRepositoryMock = CountriesRepositoryMock(countries: [country])
        
        let useCase = GetBordersUseCase()

        // Act
        let borders = useCase.execute(countryCode: "ISL")

        // Assert
        XCTAssertTrue(borders.isEmpty)
    }

    func testGetBordersWithCountryNotFound() {
        // Arrange
        let country = Country(name: "United States", alpha3Code: "USA", borders: ["CAN", "MEX"])
        countriesRepositoryMock = CountriesRepositoryMock(countries: [country])
        
        let useCase = GetBordersUseCase()

        // Act
        let borders = useCase.execute(countryCode: "GBR")

        // Assert
        XCTAssertTrue(borders.isEmpty)
    }

    func testGetBordersWithEmptyRepository() {
        // Arrange
        countriesRepositoryMock = CountriesRepositoryMock(countries: [])
        
        let useCase = GetBordersUseCase()

        // Act
        let borders = useCase.execute(countryCode: "USA")

        // Assert
        XCTAssertTrue(borders.isEmpty)
    }

    func testGetBordersWithInvalidBorders() {
        // Arrange
        let country = Country(name: "United States", alpha3Code: "USA", borders: ["XYZ", "ABC"]) // Borders that don't exist
        let canada = Country(name: "Canada", alpha3Code: "CAN", borders: [])
        
        countriesRepositoryMock = CountriesRepositoryMock(countries: [country, canada])
        
        let useCase = GetBordersUseCase()

        // Act
        let borders = useCase.execute(countryCode: "USA")

        // Assert
        XCTAssertTrue(borders.isEmpty)
    }

    func testGetBordersWithOneValidBorder() {
        // Arrange
        let country = Country(name: "United States", alpha3Code: "USA", borders: ["CAN"])
        let canada = Country(name: "Canada", alpha3Code: "CAN", borders: [])
        
        countriesRepositoryMock = CountriesRepositoryMock(countries: [country, canada])
        
        let useCase = GetBordersUseCase()

        // Act
        let borders = useCase.execute(countryCode: "USA")

        // Assert
        XCTAssertEqual(borders.count, 1)
        XCTAssertTrue(borders.contains { $0.alpha3Code == "CAN" })
    }
}
