//
//  AnySubject.swift
//  Core
//
//  Created by Taha Mahmoud on 07/01/2025.
//


import Combine
import Foundation

// swiftlint:disable identifier_name
public final class AnySubject<Output, Failure: Error>: Subject {
    public let base: Any

    let _baseAsAnyPublisher: AnyPublisher<Output, Failure>
    let _send: (Output) -> Void
    let _sendCompletion: (Subscribers.Completion<Failure>) -> Void
    let _sendSubscription: (Subscription) -> Void

    public init<S: Subject>(_ subject: S) where S.Output == Output, S.Failure == Failure {
        base = subject

        _baseAsAnyPublisher = subject.eraseToAnyPublisher()
        _send = subject.send
        _sendCompletion = subject.send
        _sendSubscription = subject.send
    }

    public func receive<S: Subscriber>(subscriber: S) where Failure == S.Failure, Output == S.Input {
        _baseAsAnyPublisher.receive(subscriber: subscriber)
    }

    public func send(_ value: Output) {
        _send(value)
    }

    public func send(completion: Subscribers.Completion<Failure>) {
        _sendCompletion(completion)
    }

    public func send(subscription: Subscription) {
        _sendSubscription(subscription)
    }
}

extension Subject {
    func eraseToAnySubject() -> AnySubject<Output, Failure> {
        return AnySubject(self)
    }
}

// swiftlint:enable identifier_name
