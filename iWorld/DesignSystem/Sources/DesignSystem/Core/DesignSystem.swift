//
//  DesignSystem.swift
//
//
//  Created by Taha Mahmoud on 19/01/2024.
//

import Foundation
import SwiftUI

public class DesignSystem {
    public static var shared = DesignSystem()
    public var selectedTheme: AppTheme = .iWorld
    public var designSystem: DesignSystemModel!
    public static var colors = DesignSystem.shared.designSystem.colors

    public init() {
        if designSystem == nil {
            designSystem = defaultDesignSystem
        }
    }

    public func setupTheme(theme: AppTheme) {
        self.selectedTheme = theme
        self.designSystem = theme.designSystem
        FontsManager.loadFonts(fontNames: theme.fontNames)
    }
}
