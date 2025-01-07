//
//  LogData.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation

public protocol LogDataProtocol {
    var file: String { get set }
    var function: String { get set }
    var line: UInt { get set }
}
public struct LogData: LogDataProtocol {
    public var file: String = ""
    public var function: String = ""
    public var line: UInt = 0

    public init(file: String, function: String, line: UInt) {
        self.file = file
        self.function = function
        self.line = line
    }
}
