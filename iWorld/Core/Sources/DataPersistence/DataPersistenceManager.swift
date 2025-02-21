//
//  DataPersistenceManager.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation

public class DataPersistenceManager: DataPersistenceManagerProtocol {
    public static let shared = DataPersistenceManager()
    var userDefaultsStorage: DataPersistenceToolsProtocol

    public init(userDefaultsStorage: DataPersistenceToolsProtocol = UserDefaultsManager.shared) {
        self.userDefaultsStorage = userDefaultsStorage
    }

    public func save<T: Cachable>(data: T, forKey key: String, using type: DataPersistenceType) {
        getPersistenceType(type: type).save(data: data, forKey: key)
    }

    public func retrieve<T: Cachable>(_ dataType: T.Type, forKey key: String, using type: DataPersistenceType) -> T? {
        getPersistenceType(type: type).retrieve(dataType, forKey: key)
    }

    public func update<T: Cachable>(data: T, forKey key: String, using type: DataPersistenceType) {
        getPersistenceType(type: type).update(data: data, forKey: key)
    }

    public func remove(forKey key: String, using type: DataPersistenceType) {
        getPersistenceType(type: type).remove(forKey: key)
    }

    private func getPersistenceType(type: DataPersistenceType) -> DataPersistenceToolsProtocol {
        switch type {
        case .userDefaults:
            return userDefaultsStorage
        }
    }
}
