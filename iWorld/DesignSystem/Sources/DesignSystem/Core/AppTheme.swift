//
//  AppTheme.swift
//
//
//  Created by Taha Mahmoud on 19/01/2024.
//

import Foundation

public enum AppTheme {
    case iWorld

    var designSystem: DesignSystemModel {
        switch self {
        case .iWorld:
            iWorldDesignSystem
        }
    }

    var fontNames: [String] {
        switch self {
        case .iWorld:
            iWorldFontNames()
        }
    }
}
