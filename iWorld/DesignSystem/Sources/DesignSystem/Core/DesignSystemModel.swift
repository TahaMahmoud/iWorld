//
//  DesignSystemModel.swift
//
//
//  Created by Taha Mahmoud on 19/01/2024.
//

import SwiftUI

public class DesignSystemModel {
    public let colors: ColorValueContainer

    public init(colors: ColorValueContainer) {
        self.colors = colors
    }
}

public struct ColorValueContainer {
    public let primary: Color
    public let secondary: Color
    public let white: Color
    public let black: Color
    public let primaryGray: Color
    public let secondaryGray: Color
    public let darkGray: Color
    public let dangor: Color
    public let gold: Color

    public init(
        primary: Color,
        secondary: Color,
        white: Color,
        black: Color,
        primaryGray: Color,
        secondaryGray: Color,
        darkGray: Color,
        dangor: Color,
        gold: Color
    ) {
        self.primary = primary
        self.secondary = secondary
        self.white = white
        self.black = black
        self.primaryGray = primaryGray
        self.secondaryGray = secondaryGray
        self.darkGray = darkGray
        self.dangor = dangor
        self.gold = gold
    }
}
