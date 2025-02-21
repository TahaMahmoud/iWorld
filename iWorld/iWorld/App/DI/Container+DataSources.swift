//
//  Container+DataSources.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation
import Factory

extension Container {
    var remoteDataSource: Factory<RemoteCountriesDataSourceProtocol> {
        self { RemoteCountriesDataSource() }.shared
    }

    var localDataSource: Factory<LocalCountriesDataSourceProtocol> {
        self { LocalCountriesDataSource() }.shared
    }
}
