//
//  Container+DataSources.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation
import Networking

extension DIContainer {
    static var remoteDataSource: RemoteCountriesDataSourceProtocol {
        RemoteCountriesDataSource(networkingManger: NetworkManager(
            responseHandler: NetworkResponseHandler(), authProvider: nil
        ))
    }

    static var localDataSource: LocalCountriesDataSourceProtocol {
        LocalCountriesDataSource()
    }
}
