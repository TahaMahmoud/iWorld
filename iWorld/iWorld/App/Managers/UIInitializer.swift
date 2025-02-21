//
//  UIInitializer.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation
import Core
import UIKit

struct UIInitializer: AppDelegateManagable {
    static var shared: AppDelegateManagable = UIInitializer()

    func setup() {
        UITabBar.appearance().isHidden = true
    }
}
