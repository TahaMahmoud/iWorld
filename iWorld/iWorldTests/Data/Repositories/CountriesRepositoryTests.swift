//
//  CountriesRepositoryTests.swift
//  iWorld
//
//  Created by Taha Mahmoud on 09/01/2025.
//

import Factory
@testable import iWorld
import XCTest

final class CountriesRepositoryTests: XCTestCase {
    fileprivate var remoteCountriesDataSourceMock: RemoteCountriesDataSourceMock!
    fileprivate var localCountriesDataSourceMock: LocalCountriesDataSourceMock!

    override func setUp() {
        super.setUp()

        // Mock Remote and Local Data Sources
        remoteCountriesDataSourceMock = RemoteCountriesDataSourceMock()
        localCountriesDataSourceMock = LocalCountriesDataSourceMock()

        // Register the mock data sources
        Container.shared.remoteDataSource.register { self.remoteCountriesDataSourceMock }
        Container.shared.localDataSource.register { self.localCountriesDataSourceMock }
    }

    func testFetchCountriesData() async throws {
        // Arrange
        let mockCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington"),
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa"),
        ]
        remoteCountriesDataSourceMock.countries = mockCountries

        // Act
        let countriesRepository = CountriesRepository()
        await countriesRepository.fetchCountriesData()

        // Assert
        XCTAssertEqual(countriesRepository.getCountries().count, 2)
        XCTAssertTrue(countriesRepository.getCountries().contains { $0.alpha3Code == "USA" })
    }

    func testGetHighlightedCountries() throws {
        // Arrange
        let highlightedCountries = [
            Country(name: "USA", alpha3Code: "USA", capital: "Washington"),
        ]
        localCountriesDataSourceMock.highlightedCountries = highlightedCountries

        // Act
        let countriesRepository = CountriesRepository()
        let result = countriesRepository.getHighlightedCountries()

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(result.contains { $0.alpha3Code == "USA" })
    }

    func testGetSavedCountries() throws {
        // Arrange
        let savedCountries = [
            Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa"),
            Country(name: "Mexico", alpha3Code: "MEX", capital: "Mexico City"),
        ]
        localCountriesDataSourceMock.savedCountries = savedCountries

        // Act
        let countriesRepository = CountriesRepository()
        let result = countriesRepository.getSavedCountries(limit: 1)

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(result.contains { $0.alpha3Code == "CAN" })
    }

    func testHighlightCountry() async {
        // Arrange
        let mockCountry = Country(name: "USA", alpha3Code: "USA", capital: "Washington")
        remoteCountriesDataSourceMock.countries = [mockCountry]
        localCountriesDataSourceMock.highlightedCountries = []

        // Act
        let countriesRepository = CountriesRepository()
        await countriesRepository.fetchCountriesData()
        countriesRepository.highlightCountry(withCode: "USA")

        // Assert
        XCTAssertTrue(localCountriesDataSourceMock.highlightedCountries.contains { $0.alpha3Code == "USA" })
    }

    func testSaveCountry() async throws {
        // Arrange
        let mockCountry = Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa")
        remoteCountriesDataSourceMock.countries = [mockCountry]
        localCountriesDataSourceMock.savedCountries = []

        // Act
        let countriesRepository = CountriesRepository()
        await countriesRepository.fetchCountriesData()
        countriesRepository.saveCountry(withCode: "CAN")

        // Assert
        XCTAssertTrue(localCountriesDataSourceMock.savedCountries.contains { $0.alpha3Code == "CAN" })
    }

    func testRemoveFromHighlighted() async throws {
        // Arrange
        let mockCountry = Country(name: "USA", alpha3Code: "USA", capital: "Washington")
        localCountriesDataSourceMock.highlightedCountries = [mockCountry]

        // Act
        let countriesRepository = CountriesRepository()
        await countriesRepository.fetchCountriesData()
        countriesRepository.removeFromHighlighted(withCode: "USA")

        // Assert
        XCTAssertFalse(localCountriesDataSourceMock.highlightedCountries.contains { $0.alpha3Code == "USA" })
    }

    func testRemoveFromSaved() async throws {
        // Arrange
        let mockCountry = Country(name: "Canada", alpha3Code: "CAN", capital: "Ottawa")
        localCountriesDataSourceMock.savedCountries = [mockCountry]

        // Act
        let countriesRepository = CountriesRepository()
        await countriesRepository.fetchCountriesData()
        countriesRepository.removeFromSaved(withCode: "CAN")

        // Assert
        XCTAssertFalse(localCountriesDataSourceMock.savedCountries.contains { $0.alpha3Code == "CAN" })
    }
}
