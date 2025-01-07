//
// Codable+Extensions.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation

public extension Encodable {
    func asDictionary() -> [String: Any] {
        let serialized = (try? JSONSerialization.jsonObject(with: encode(), options: .allowFragments)) ?? nil
        return serialized as? [String: Any] ?? [String: Any]()
    }

    func encode() -> Data {
        return (try? JSONEncoder().encode(self)) ?? Data()
    }
}

public extension Data {
    func decode<T: Codable>(_ object: T.Type) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: self)
        } catch {
            print(error)
            return nil
        }
    }
}
