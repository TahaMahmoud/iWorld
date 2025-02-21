//
//  LoggerManager.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation
import Logger
import Core

struct LoggerManager: AppDelegateManagable {
    static var shared: AppDelegateManagable = LoggerManager()

    func setup() {
        LogsManager.shared.initialize(engines: [Logger.systemLogger.engine])
    }
}
