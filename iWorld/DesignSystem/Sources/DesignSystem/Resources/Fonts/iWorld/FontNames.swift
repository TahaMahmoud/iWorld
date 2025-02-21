//
//  FontNames.swift
//
//
//  Created by Taha Mahmoud on 19/01/2024.
//

import Foundation
import SwiftUI

internal func iWorldFontNames() -> [String] {
    return [
        "Gellix-Black",
        "Gellix-BlackItalic",
        "Gellix-Bold",
        "Gellix-BoldItalic",
        "Gellix-ExtraBold",
        "Gellix-ExtraBoldItalic",
        "Gellix-Light",
        "Gellix-LightItalic",
        "Gellix-Medium",
        "Gellix-MediumItalic",
        "Gellix-Regular",
        "Gellix-RegularItalic",
        "Gellix-SemiBold",
        "Gellix-SemiBoldItalic",
        "Gellix-Thin",
        "Gellix-ThinItalic",
    ]
}

public extension Font {
    static func gellix(weight: GellixFontWeight, size: CGFloat) -> Font {
        Font.custom("Gellix-\(weight.rawValue)", size: size)
    }
}

public enum GellixFontWeight: String {
    case black = "Black"
    case blackItalic = "BlackItalic"
    case bold = "Bold"
    case boldItalic = "BoldItalic"
    case extraBold = "ExtraBold"
    case extraBoldItalic = "ExtraBoldItalic"
    case light = "Light"
    case lightItalic = "LightItalic"
    case medium = "Medium"
    case mediumItalic = "MediumItalic"
    case regular = "Regular"
    case regularItalic = "RegularItalic"
    case semiBold = "SemiBold"
    case semiBoldItalic = "SemiBoldItalic"
    case thin = "Thin"
    case thinItalic = "ThinItalic"
}
