//
//  SystemLogger.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation

public final class SystemLogger: LogsEngineProtocol {
    public static let main: SystemLogger = .init()
    public init() {}

    public func info(message: String,
                     metaData: [String: Encodable]?,
                     logData: LogDataProtocol) {
        debugPrint(
            """
             ℹ️ \n Message: \(message) \n File: \(logData.file)
              \n Function:\(logData.function) \n Line:\(logData.line) \nℹ️
            """
        )
    }

    public func warn(message: String,
                     metaData: [String: Encodable]?,
                     logData: LogDataProtocol) {
        debugPrint(
            """
            ⚠️ \n Message: \(message) \n File: \(logData.file)
              \n Function:\(logData.function) \n Line:\(logData.line) \n⚠️
            """
        )
    }

    public func error(message: String,
                      metaData: [String: Encodable]?,
                      error: Error?,
                      logData: LogDataProtocol) {
        debugPrint(
            """
            🔴 \n Message: \(message) \n File: \(logData.file)
              \n Function:\(logData.function) \n Line:\(logData.line) \n🔴
            """
        )
    }

    public func critical(message: String,
                         metaData: [String: Encodable]?,
                         error: Error?,
                         logData: LogDataProtocol) {
        debugPrint(
            """
            🔴‼️ \n Message: \(message) \n File: \(logData.file)
              \n Function:\(logData.function) \n Line:\(logData.line) \n‼️🔴
            """
        )
    }

    public func debug(message: String,
                      metaData: [String: Encodable]?,
                      logData: LogDataProtocol) {
        debugPrint(
            """
             ℹ️ \n Message: \(message) \n File: \(logData.file)
              \n Function:\(logData.function) \n Line:\(logData.line) \nℹ️
            """
        )
    }

    public func notice(message: String,
                       metaData: [String: Encodable]?,
                       logData: LogDataProtocol) {
        debugPrint(
            """
             ℹ️ \n Message: \(message) \n File: \(logData.file)
              \n Function:\(logData.function) \n Line:\(logData.line) \nℹ️
            """
        )
    }
}
