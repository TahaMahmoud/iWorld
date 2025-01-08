//
//  GetRegionsUseCase.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation

protocol GetRegionsUseCaseProtocol {
    func execute() -> [Region]
}

struct GetRegionsUseCase: GetRegionsUseCaseProtocol {
    func execute() -> [Region] {
        Region.allCases
    }
}
