//
//  UserDefaultsManager.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation

public class UserDefaultsManager: DataPersistenceToolsProtocol {
    public static let shared = UserDefaultsManager()

    public init() {}

    public func save<T: Codable>(data: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(data) {
            UserDefaults.standard.set(encodedData, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }

    public func update<T: Codable>(data: T, forKey key: String) {
        save(data: data, forKey: key)
    }

    public func remove(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }

    public func retrieve<T: Decodable>(_ dataType: T.Type, forKey key: String) -> T? {
        if let data = UserDefaults.standard.data(forKey: key) {
            let decoder = JSONDecoder()
            return try? decoder.decode(dataType, from: data)
        }
        return nil
    }
}
