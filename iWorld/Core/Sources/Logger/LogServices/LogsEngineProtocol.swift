//
//  LogsEngineProtocol.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation

public protocol LogsEngineProtocol {
    func setup(configuration: Any?)

    func info(message: String,
              metaData: [String: Encodable]?,
              logData: LogDataProtocol)

    func debug(message: String,
               metaData: [String: Encodable]?,
               logData: LogDataProtocol)

    func notice(message: String,
                metaData: [String: Encodable]?,
                logData: LogDataProtocol)

    func warn(message: String,
              metaData: [String: Encodable]?,
              logData: LogDataProtocol)

    func error(message: String,
               metaData: [String: Encodable]?,
               error: Error?,
               logData: LogDataProtocol)

    func critical(message: String,
                  metaData: [String: Encodable]?,
                  error: Error?,
                  logData: LogDataProtocol)
}

public extension LogsEngineProtocol {
    func setup(configuration: Any? = nil) {}
    func info(message: String,
              metaData: [String: Encodable]?,
              logData: LogDataProtocol) {}

    func warn(message: String,
              metaData: [String: Encodable]?,
              logData: LogDataProtocol) {}

    func error(message: String,
               metaData: [String: Encodable]?,
               error: Error?,
               logData: LogDataProtocol) {}

    func debug(message: String,
               metaData: [String: Encodable]?,
               logData: LogDataProtocol) {}

    func notice(message: String,
                metaData: [String: Encodable]?,
                logData: LogDataProtocol) {}

    func critical(message: String,
                  metaData: [String: Encodable]?,
                  error: Error?,
                  logData: LogDataProtocol) {}
}
