//
//  ShimmerRectangularView.swift
//  DesignSystem
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import SwiftUI

public struct ShimmerRectangularView: View {
    @State private var opacity: Double = 0.25

    var duration: Double = 1.25
    var maxOpacity: Double = 1.0
    var cornerRadius: CGFloat = 4.0
    var fillColor: Color = DesignSystem.colors.secondary

    public init() {}
    
    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(fillColor)
            .opacity(opacity)
            .transition(.opacity)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: duration)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                withAnimation(repeated) {
                    self.opacity = maxOpacity
                }
            }
    }
}
