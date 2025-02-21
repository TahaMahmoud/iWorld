//
//  DesignSystemConfigurator.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import Foundation
import DesignSystem
import Core

struct DesignSystemConfigurator: AppDelegateManagable {
    static var shared: AppDelegateManagable = DesignSystemConfigurator()

    func setup() {
        DesignSystem.shared.setupTheme(theme: .iWorld)
    }
}
