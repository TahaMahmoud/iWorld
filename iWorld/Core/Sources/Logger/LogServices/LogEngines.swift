//
//  LogEngines.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation

public enum Logger: CaseIterable {
    case systemLogger

    public var engine: LogsEngineProtocol {
        switch self {
        case .systemLogger:
            return SystemLogger.main
        }
    }
}
