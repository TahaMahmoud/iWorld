//
//  IconButton.swift
//  DesignSystem
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import SwiftUI
import Core

struct IconButton: View {
    let icon: Image
    let color: Color
    let action: Action

    var body: some View {
        Button(action: action) {
            icon
                .resizable()
                .foregroundStyle(color)
                .padding(8)
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
