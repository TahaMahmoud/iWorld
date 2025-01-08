//
//  NavigationBarView.swift
//  DesignSystem
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import SwiftUI
import Core

public struct NavigationBarView: View {
    let title: String
    let backAction: Action

    public init(
        title: String = "",
        backAction: @escaping Action
    ) {
        self.title = title
        self.backAction = backAction
    }
    
    public var body: some View {
        HStack {
            Button(
                action: backAction
            ) {
                Image(.icBack)
            }
            .frame(width: 40, height: 40)
            .background(DesignSystem.colors.secondary)
            .clipShape(RoundedCorner(radius: 8))

            Spacer()

            Text(title)
                .foregroundStyle(DesignSystem.colors.black)
                .font(Font.gellix(weight: .regular, size: 14))
                .padding(.top, 10)

            Spacer()
        }
    }
}

#Preview("Title") {
    NavigationBarView(
        title: "All Countries",
        backAction: {}
    )
    .padding(.horizontal)
}

#Preview("Without Title") {
    NavigationBarView(backAction: {})
        .padding(.horizontal)
}
