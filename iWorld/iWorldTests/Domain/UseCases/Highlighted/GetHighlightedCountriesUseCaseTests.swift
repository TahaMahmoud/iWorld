//
//  GetHighlightedCountriesUseCaseTests.swift
//  iWorldTests
//
//  Created by Taha Mahmoud on 09/01/2025.
//

import Factory
@testable import iWorld
import XCTest

final class GetHighlightedCountriesUseCaseTests: iWorldTestCase {
    fileprivate var useCase: GetHighlightedCountriesUseCase!
    fileprivate var countriesRepositoryMock: CountriesRepositoryMock!
    fileprivate var getCountryDetailsUseCaseMock: GetCountryDetailsUseCaseMock!
    fileprivate var getCurrentLocationUseCaseMock: GetCurrentLocationUseCaseMock!

    override func setUp() {
        super.setUp()

        countriesRepositoryMock = CountriesRepositoryMock()
        getCountryDetailsUseCaseMock = GetCountryDetailsUseCaseMock()
        getCurrentLocationUseCaseMock = GetCurrentLocationUseCaseMock()

        Container.shared.countriesRepo.register { self.countriesRepositoryMock }
        Container.shared.getCountryDetailsUseCase.register { self.getCountryDetailsUseCaseMock }
        Container.shared.getCurrentLocationUseCase.register { self.getCurrentLocationUseCaseMock }

        useCase = GetHighlightedCountriesUseCase()
    }

    func testExecuteWithCurrentCountryInHighlighted() {
        // Arrange
        let currentCountryName = "Egypt"
        let highlightedCountries = [Country(name: "USA", alpha3Code: "USA")]
        countriesRepositoryMock.highlightedCountries = highlightedCountries
        getCountryDetailsUseCaseMock.country = Country(name: "Egypt", alpha3Code: "EGY")

        // Act
        let result = useCase.execute(currentCountryName: currentCountryName)

        // Assert
        XCTAssertEqual(result.count, highlightedCountries.count + 1)
        XCTAssertEqual(result.first?.alpha3Code, "EGY")
        XCTAssertEqual(result[1].alpha3Code, "USA")
    }

    func testExecuteWithEmptyHighlightedCountries() {
        // Arrange
        let currentCountryName = "Egypt"
        countriesRepositoryMock.highlightedCountries = []
        getCountryDetailsUseCaseMock.country = Country(name: "Egypt", alpha3Code: "EGY")

        // Act
        let result = useCase.execute(currentCountryName: currentCountryName)

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.alpha3Code, "EGY")
    }

    func testExecuteWithMissingCountryDetails() {
        // Arrange
        let currentCountryName = "UnknownCountry"
        countriesRepositoryMock.highlightedCountries = []
        getCountryDetailsUseCaseMock.country = nil

        // Act
        let result = useCase.execute(currentCountryName: currentCountryName)

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.alpha3Code, "EGY")
    }

    func testExecuteWithDefaultCountry() {
        // Arrange
        let currentCountryName = "UnknownCountry"
        countriesRepositoryMock.highlightedCountries = []
        getCountryDetailsUseCaseMock.country = nil

        // Act
        let result = useCase.execute(currentCountryName: currentCountryName)

        // Assert
        XCTAssertEqual(result.first?.alpha3Code, "EGY")
    }
}

class GetCountryDetailsUseCaseMock: GetCountryDetailsUseCaseProtocol {
    var country: Country?

    func execute(countyCode: String) -> Country? {
        return country
    }

    func execute(countryName: String) -> Country? {
        return country
    }
}

class GetCurrentLocationUseCaseMock: GetCurrentLocationUseCaseProtocol {
    func execute() async throws -> LocationDetails {
        return LocationDetails(latitude: 26.8206, longitude: 30.8025)
    }
}
