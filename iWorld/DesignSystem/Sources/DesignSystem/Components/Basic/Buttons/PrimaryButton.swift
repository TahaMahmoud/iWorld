//
//  PrimaryButton.swift
//
//
//  Created by Taha Mahmoud on 19/01/2024.
//

import Core
import SwiftUI

public struct PrimaryButton: View {
    public var icon: Image?
    public var title: String?
    public var action: Action

    public init(icon: Image? = nil,
                title: String? = nil,
                action: @escaping Action) {
        self.icon = icon
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack {
                icon
                Text(title ?? "")
            }
            .frame(maxWidth: .infinity, minHeight: 36)
            .padding(.vertical, 14)
            .background(DesignSystem.colors.primary)
            .foregroundStyle(DesignSystem.colors.secondary)
            .font(Font.gellix(weight: .bold, size: 16))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    PrimaryButton(
        icon: Image(systemName: "plus"),
        title: "Details"
    ) {
        print("")
    }
}
