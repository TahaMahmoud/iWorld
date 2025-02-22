//
//  OnboardingView.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import DesignSystem
import SwiftUI
import Core

struct OnboardingView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        ZStack {
            Image(.onboarding)
                .resizable()
                .ignoresSafeArea()

            VStack {
                Spacer()
                    .frame(maxHeight: 100)

                Image(.lightLogo)

                Spacer()

                VStack(alignment: .leading) {
                    Text("Creatively")
                        .foregroundStyle(DesignSystem.colors.white)
                        .font(Font.gellix(weight: .regular, size: 24))

                    Text("Discover The World!")
                        .foregroundStyle(DesignSystem.colors.white)
                        .font(Font.gellix(weight: .medium, size: 40))
                        .padding(.trailing, 20)

                    PrimaryButton(title: "Explore", action: {
                        router.navigate(to: .home)
                    })
                }
                .padding(.bottom, 32)
            }
            .padding(.horizontal, 32)
        }
        .onAppear {
            LocationManager.shared.requestAuthorisation()
        }
    }
}

#Preview {
    OnboardingView()
}
