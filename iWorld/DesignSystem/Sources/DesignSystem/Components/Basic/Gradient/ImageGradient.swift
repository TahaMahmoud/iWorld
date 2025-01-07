//
//  ImageGradient.swift
//
//
//  Created by Taha Mahmoud on 20/01/2024.
//

import SwiftUI

public struct ImageGradient: View {
    public init() {}
    public var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [DesignSystem.colors.black.opacity(0.6), Color.clear]),
            startPoint: .bottom,
            endPoint: .top)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    ImageGradient()
}
