//
//  EmptyStateView.swift
//  DesignSystem
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import SwiftUI

public struct EmptyStateView: View {
    let image: Image?
    let title: String?
    let subtitle: String?

    public init(
        image: Image? = nil,
        title: String? = "",
        subtitle: String? = ""
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }

    public var body: some View {
        VStack {
            image

            Text(title ?? "")
                .foregroundStyle(DesignSystem.colors.black)
                .font(Font.gellix(weight: .bold, size: 20))
                .padding(.top, 16)
                .multilineTextAlignment(.center)

            Text(subtitle ?? "")
                .foregroundStyle(DesignSystem.colors.black)
                .font(Font.gellix(weight: .regular, size: 20))
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    EmptyStateView(
        image: Image(systemName: "cart"),
        title: "No results found",
        subtitle: "Try adjusting your search to find what you are looking for"
    )
}
