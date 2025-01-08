//
//  IconButton.swift
//  DesignSystem
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import SwiftUI
import Core

public struct IconButton: View {
    let icon: Image
    let color: Color
    let action: Action
    let padding: CGFloat
    
    public init(icon: Image, color: Color, padding: CGFloat = 8, action: @escaping Action) {
        self.icon = icon
        self.color = color
        self.padding = padding
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            icon
                .resizable()
                .foregroundStyle(color)
                .padding(padding)
                .background(DesignSystem.colors.white)
                .clipShape(Circle())
                .shadow(color: DesignSystem.colors.primary.opacity(0.2), radius: 25, x: 0, y: 6)
        }
    }
}

#Preview {
    IconButton(
        icon: Image(systemName: "heart.fill"),
        color: DesignSystem.colors.dangor,
        action: {}
    )
    .frame(width: 40, height: 40)
}
