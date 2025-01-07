//
//  DataPersistenceManagerProtocol.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation

public protocol DataPersistenceWritableProtocol {
    func save<T: Cachable>(data: T,
                           forKey key: String,
                           using type: DataPersistenceType)
    func update<T: Cachable>(data: T,
                             forKey key: String,
                             using type: DataPersistenceType)
    func remove(forKey key: String,
                using type: DataPersistenceType)
}

public protocol DataPersistenceReadableProtocol {
    func retrieve<T: Cachable>(_ dataType: T.Type,
                               forKey key: String,
                               using type: DataPersistenceType) -> T?
}

public protocol DataPersistenceManagerProtocol: DataPersistenceWritableProtocol,
    DataPersistenceReadableProtocol {
}

public protocol DataPersistenceToolsProtocol {
    func save<T: Cachable>(data: T, forKey key: String)
    func update<T: Cachable>(data: T, forKey key: String)
    func remove(forKey key: String)
    func retrieve<T: Cachable>(_ dataType: T.Type,
                               forKey key: String) -> T?
}

public protocol Cachable: Codable { }

extension String: Cachable { }
extension Int: Cachable { }
extension Data: Cachable { }
extension Float: Cachable { }
extension Double: Cachable { }
extension Array: Cachable where Iterator.Element: Cachable { }
extension Date: Cachable { }
extension Bool: Cachable { }
