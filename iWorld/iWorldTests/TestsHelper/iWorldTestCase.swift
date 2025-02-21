//
//  iWorldTestCase.swift
//  iWorldTests
//
//  Created by Taha Mahmoud on 09/01/2025.
//

import Combine
import Factory
import XCTest

class iWorldTestCase: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    override func tearDown() {
        Container.shared.reset()
        super.tearDown()
    }
}

enum TestError: LocalizedError {
    case general(String)

    var errorDescription: String? {
        switch self {
        case let .general(errorMessage):
            return errorMessage
        }
    }
}
