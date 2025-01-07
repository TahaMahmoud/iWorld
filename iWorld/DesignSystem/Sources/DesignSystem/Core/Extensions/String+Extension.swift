//
//  String+Extension.swift
//
//
//  Created by Taha Mahmoud on 19/01/2024.
//

import Foundation

public extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
