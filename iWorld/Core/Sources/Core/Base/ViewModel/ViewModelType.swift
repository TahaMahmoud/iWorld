//
//  ViewModelType.swift
//  Core
//
//  Created by Taha Mahmoud on 07/01/2025.
//


import Combine
import Foundation

public typealias AnyUIEvent<T> = AnySubject<T, Never>

public extension AnyUIEvent {
    static func create<T>() -> AnyUIEvent<T> {
        return PassthroughSubject<T, Never>().eraseToAnySubject()
    }
}

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
}
