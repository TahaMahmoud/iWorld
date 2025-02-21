//
//  AnyShape.swift
//
//
//  Created by Taha Mahmoud on 17/01/2024.
//

import SwiftUI

public struct AnyShape: Shape {
    private let makePath: (CGRect) -> Path

    public init<S: Shape>(_ shape: S) {
        makePath = { rect in
            shape.path(in: rect)
        }
    }

    public func path(in rect: CGRect) -> Path {
        makePath(rect)
    }
}
