//
//  DataPersistenceKeys.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation

public struct DataPersistenceKey: RawRepresentable {
    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
