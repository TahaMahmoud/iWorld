//
//  Container+Managers.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation
import Factory
import Networking
import DataPersistence

extension Container {
    var networkManager: Factory<NetworkManagerProtocol> {
        self { NetworkManager(responseHandler: NetworkResponseHandler(), authProvider: nil) }.shared
    }

    var dataManager: Factory<DataPersistenceManager> {
        self { DataPersistenceManager() }
    }
}
