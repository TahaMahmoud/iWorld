//
//  GetCountryDetailsUseCaseTests.swift
//  iWorldTests
//
//  Created by Taha Mahmoud on 09/01/2025.
//

import Combine
import Factory
@testable import iWorld
import XCTest

final class GetCountryDetailsUseCaseTests: iWorldTestCase {
    fileprivate var countriesRepositoryMock: CountriesRepositoryMock!

    override func setUp() {
        super.setUp()
        countriesRepositoryMock = CountriesRepositoryMock()
        Container.shared.countriesRepo.register { self.countriesRepositoryMock }
    }

    func testGetCountryDetailsByValidCountryCode() {
        // Arrange
        let country = Country(name: "United States", alpha3Code: "USA", borders: ["CAN", "MEX"])
        countriesRepositoryMock = CountriesRepositoryMock(countries: [country])

        let useCase = GetCountryDetailsUseCase()

        // Act
        let countryDetails = useCase.execute(countyCode: "USA")

        // Assert
        XCTAssertNotNil(countryDetails)
        XCTAssertEqual(countryDetails?.alpha3Code, "USA")
        XCTAssertEqual(countryDetails?.name, "United States")
    }

    func testGetCountryDetailsByInvalidCountryCode() {
        // Arrange
        let country = Country(name: "United States", alpha3Code: "USA", borders: ["CAN", "MEX"])
        countriesRepositoryMock = CountriesRepositoryMock(countries: [country])

        let useCase = GetCountryDetailsUseCase()

        // Act
        let countryDetails = useCase.execute(countyCode: "GBR")

        // Assert
        XCTAssertNil(countryDetails)
    }

    func testGetCountryDetailsByValidCountryName() {
        // Arrange
        let country = Country(name: "United States", alpha3Code: "USA", borders: ["CAN", "MEX"])
        countriesRepositoryMock = CountriesRepositoryMock(countries: [country])

        let useCase = GetCountryDetailsUseCase()

        // Act
        let countryDetails = useCase.execute(countryName: "United States")

        // Assert
        XCTAssertNotNil(countryDetails)
        XCTAssertEqual(countryDetails?.alpha3Code, "USA")
        XCTAssertEqual(countryDetails?.name, "United States")
    }

    func testGetCountryDetailsByInvalidCountryName() {
        // Arrange
        let country = Country(name: "United States", alpha3Code: "USA", borders: ["CAN", "MEX"])
        countriesRepositoryMock = CountriesRepositoryMock(countries: [country])

        let useCase = GetCountryDetailsUseCase()

        // Act
        let countryDetails = useCase.execute(countryName: "Canada")

        // Assert
        XCTAssertNil(countryDetails)
    }

    func testGetCountryDetailsWithEmptyRepository() {
        // Arrange
        countriesRepositoryMock = CountriesRepositoryMock(countries: [])

        let useCase = GetCountryDetailsUseCase()

        // Act
        let countryDetailsByCode = useCase.execute(countyCode: "USA")
        let countryDetailsByName = useCase.execute(countryName: "United States")

        // Assert
        XCTAssertNil(countryDetailsByCode)
        XCTAssertNil(countryDetailsByName)
    }

    func testGetCountryDetailsWithCaseInsensitiveCountryName() {
        // Arrange
        let country = Country(name: "United States", alpha3Code: "USA", borders: ["CAN", "MEX"])
        countriesRepositoryMock = CountriesRepositoryMock(countries: [country])

        let useCase = GetCountryDetailsUseCase()

        // Act
        let countryDetails = useCase.execute(countryName: "united states")

        // Assert
        XCTAssertNotNil(countryDetails)
        XCTAssertEqual(countryDetails?.alpha3Code, "USA")
        XCTAssertEqual(countryDetails?.name, "United States")
    }
}
