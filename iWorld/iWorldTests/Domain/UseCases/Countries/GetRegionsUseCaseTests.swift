//
//  GetRegionsUseCaseTests.swift
//  iWorldTests
//
//  Created by Taha Mahmoud on 09/01/2025.
//

import Factory
@testable import iWorld
import XCTest

final class GetRegionsUseCaseTests: iWorldTestCase {
    fileprivate var useCase: GetRegionsUseCase!

    override func setUp() {
        super.setUp()
        useCase = GetRegionsUseCase()
    }

    func testGetRegions() {
        // Act
        let regions = useCase.execute()

        // Assert
        XCTAssertFalse(regions.isEmpty)
        XCTAssertEqual(regions.count, Region.allCases.count)
    }
}
