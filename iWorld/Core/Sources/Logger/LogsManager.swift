//
//  LogsManager.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation

public struct EngineConfiguration {
    public var engine: LogsEngineProtocol
    public var configuration: Any?
    public init(engine: LogsEngineProtocol, configuration: Any? = nil) {
        self.engine = engine
        self.configuration = configuration
    }
}

public struct LogsManager: LogsManagerProtcol {
    public static var shared = LogsManager()
    public var engines: [LogsEngineProtocol] = []

    public mutating func initialize(engines: [LogsEngineProtocol] = []) {
        self.engines = !engines.isEmpty ? engines : Logger.allCases.map { $0.engine }
    }

    public func configure(configurations: [EngineConfiguration]) {
        for config in configurations {
            config.engine.setup(configuration: config)
        }
    }

    public func configure(configuration: EngineConfiguration) {
        if let config = configuration.configuration {
            configuration.engine.setup(configuration: config)
        } else {
            debugPrint(
                """
                🔴‼️ \n Message: Failed to install \(configuration.engine),
                Check the configuration)‼️🔴
                """
            )
        }
    }

    public mutating func info(message: String,
                              metaData: [String: Encodable]? = [:],
                              logData: LogDataProtocol = LogData(
                                  file: #file,
                                  function: #function,
                                  line: #line),
                              engines: [LogsEngineProtocol]? = []) {
        if !(engines?.isEmpty ?? true) {
            self.engines = engines ?? []
        }

        print("engines: \(self.engines)")
        self.engines.forEach {
            $0.info(message: message,
                    metaData: metaData,
                    logData: logData
            )
        }
    }

    public mutating func warn(message: String,
                              metaData: [String: String]? = [:],
                              logData: LogDataProtocol = LogData(
                                  file: #file,
                                  function: #function,
                                  line: #line),
                              engines: [LogsEngineProtocol]? = []) {
        if !(engines?.isEmpty ?? true) {
            self.engines = engines ?? []
        }

        self.engines.forEach {
            $0.warn(message: message,
                    metaData: metaData,
                    logData: logData
            )
        }
    }

    public mutating func error(message: String,
                               metaData: [String: String]? = [:],
                               error: Error? = nil,
                               logData: LogDataProtocol = LogData(
                                   file: #file,
                                   function: #function,
                                   line: #line),
                               engines: [LogsEngineProtocol]? = []) {
        if !(engines?.isEmpty ?? true) {
            self.engines = engines ?? []
        }

        self.engines.forEach {
            $0.error(message: message,
                     metaData: metaData,
                     error: error,
                     logData: logData
            )
        }
    }

    public mutating func debug(message: String,
                               metaData: [String: String]? = [:],
                               error: Error? = nil,
                               logData: LogDataProtocol = LogData(
                                   file: #file,
                                   function: #function,
                                   line: #line),
                               engines: [LogsEngineProtocol]? = []) {
        if !(engines?.isEmpty ?? true) {
            self.engines = engines ?? []
        }

        self.engines.forEach {
            $0.debug(message: message,
                     metaData: metaData,
                     logData: logData
            )
        }
    }

    public mutating func notice(message: String,
                                metaData: [String: String]? = [:],
                                error: Error? = nil,
                                logData: LogDataProtocol = LogData(
                                    file: #file,
                                    function: #function,
                                    line: #line),
                                engines: [LogsEngineProtocol]? = []) {
        if !(engines?.isEmpty ?? true) {
            self.engines = engines ?? []
        }

        self.engines.forEach {
            $0.notice(message: message,
                      metaData: metaData,
                      logData: logData
            )
        }
    }

    public mutating func critical(message: String,
                                  metaData: [String: String]? = [:],
                                  error: Error? = nil,
                                  logData: LogDataProtocol = LogData(
                                      file: #file,
                                      function: #function,
                                      line: #line),
                                  engines: [LogsEngineProtocol]? = []) {
        if !(engines?.isEmpty ?? true) {
            self.engines = engines ?? []
        }

        self.engines.forEach {
            $0.critical(message: message,
                        metaData: metaData,
                        error: error,
                        logData: logData
            )
        }
    }
}
