//
//  FontsLoader.swift
//
//
//  Created by Taha Mahmoud on 19/01/2024.
//

import CoreGraphics
import CoreText
import Foundation
import SwiftUI

public class FontsManager {
    public static func loadFonts(fontNames: [String]) {
        for fileName in fontNames {
            if let fontURL = Bundle.module.url(forResource: fileName, withExtension: "ttf"),
               let fontData = try? Data(contentsOf: fontURL) {
                if let provider = CGDataProvider(data: fontData as CFData),
                   let font = CGFont(provider) {
                    if CTFontManagerRegisterGraphicsFont(font, nil) {
                        print("Font \(fileName) registered successfully")
                    } else {
                        print("Font \(fileName) registration failed")
                    }
                }
            }
        }
    }
}
