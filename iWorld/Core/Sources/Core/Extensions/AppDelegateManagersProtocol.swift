//
//  AppDelegateManagersProtocol.swift
//
//
//  Created by Taha Mahmoud on 07/01/2024.
//

import Foundation

public protocol Setupable {
    func setup()
}

public protocol Listenable {
    func listen()
}

public protocol AppDelegateManagable: Setupable, Listenable {
    static var shared: AppDelegateManagable { get }
}

public  extension AppDelegateManagable {
    func setup() {}
    func listen() {}
}
