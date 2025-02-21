//
//  LogsManagerProtcol.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation

public protocol LogsManagerProtcol {
    func setup(configuration: Any?)

    func info(message: String,
              metaData: [String: Encodable]?,
              logData: LogDataProtocol,
              engines: [LogsManagerProtcol]?)

    func debug(message: String,
               metaData: [String: Encodable]?,
               logData: LogDataProtocol,
               engines: [LogsManagerProtcol]?)

    func notice(message: String,
                metaData: [String: Encodable]?,
                logData: LogDataProtocol,
                engines: [LogsManagerProtcol]?)

    func warn(message: String,
              metaData: [String: Encodable]?,
              logData: LogDataProtocol,
              engines: [LogsManagerProtcol]?)

    func error(message: String,
               metaData: [String: Encodable]?,
               error: Error?,
               logData: LogDataProtocol,
               engines: [LogsManagerProtcol]?)

    func critical(message: String,
                  metaData: [String: Encodable]?,
                  error: Error?,
                  logData: LogDataProtocol,
                  engines: [LogsManagerProtcol]?)
}

public extension LogsManagerProtcol {
    func setup(configuration: Any? = nil) {}
    func info(message: String,
              metaData: [String: Encodable]?,
              logData: LogDataProtocol,
              engines: [LogsManagerProtcol]? = []) {}

    func warn(message: String,
              metaData: [String: Encodable]?,
              logData: LogDataProtocol,
              engines: [LogsManagerProtcol]? = []) {}

    func error(message: String,
               metaData: [String: Encodable]?,
               error: Error?,
               logData: LogDataProtocol,
               engines: [LogsManagerProtcol]? = []) {}

    func debug(message: String,
               metaData: [String: Encodable]?,
               logData: LogDataProtocol,
               engines: [LogsManagerProtcol]? = []) {}

    func notice(message: String,
                metaData: [String: Encodable]?,
                logData: LogDataProtocol,
                engines: [LogsManagerProtcol]? = []) {}

    func critical(message: String,
                  metaData: [String: Encodable]?,
                  error: Error?,
                  logData: LogDataProtocol,
                  engines: [LogsManagerProtcol]? = []) {}
}
