//
//  ViewModel.swift
//  Core
//
//  Created by Taha Mahmoud on 07/01/2025.
//


import Foundation
import Combine

public protocol ViewModelProtocol {}

open class ViewModel: NSObject {
    public var cancellables = Set<AnyCancellable>()
}

extension ViewModel: ViewModelProtocol {}
