//
//  Container+Repositories.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Foundation
import Factory

extension Container {
    var countriesRepo: Factory<CountriesRepositoryProtocol> {
        self { CountriesRepository() } .shared
    }
}
