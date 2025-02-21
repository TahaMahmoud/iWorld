//
//  FavouritesView.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Core
import DesignSystem
import SwiftUI

struct FavouritesView: View {
    @StateObject private var input: FavouritesViewModel.Input
    @StateObject private var output: FavouritesViewModel.Output
    @EnvironmentObject var router: Router

    init(viewModel: FavouritesViewModelProtocol) {
        _input = .init(wrappedValue: viewModel.input)
        _output = .init(wrappedValue: viewModel.output)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            NavigationBarView(
                title: "Saved Countries",
                backAction: input.backTapped.send
            )

            GenericView(
                state: output.state,
                emptyView: {
                    makeEmptyView()
                },
                errorView: { _ in
                    makeGeneralErrorView()
                },
                loadingView: {
                    makeLoadingView()
                },
                loadedView: {
                    makeFavouritesView()
                }
            )

            Spacer()
        }
        .onAppear {
            input.viewOnAppear.send()
        }
        .padding(.horizontal, 24)
        .navigationBarHidden(true)
        .onReceive(output.$shouldBack) { shouldBack in
            if shouldBack {
                router.navigateBack()
            }
        }
        .onReceive(output.$selectedCountryCode) { selectedCountryCode in
            if let selectedCountryCode {
                router.navigate(to: .countryDetails(countryCode: selectedCountryCode))
            }
        }
    }

    func makeEmptyView() -> some View {
        VStack {
            Spacer()

            EmptyStateView(
                image: Image(.icEmptySearch),
                title: "No results found",
                subtitle: "Try adding a country to your favourites"
            )

            Spacer()
        }
    }

    func makeGeneralErrorView() -> some View {
        VStack {
            Spacer()

            EmptyStateView(
                image: Image(.icEmptySearch),
                title: "Something went wrong",
                subtitle: "Try pulling the view down to refresh"
            )

            Spacer()
        }
    }

    func makeLoadingView() -> some View {
        VStack {
            ForEach(0 ..< 10) { _ in
                ShimmerRectangularView()
            }
        }
    }

    func makeFavouritesView() -> some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(output.countries, id: \.id) { country in
                    Button(action: {
                        input.countryTapped.send(country.id)
                    }, label: {
                        makeCountryCardView(country: country)
                    })
                }
            }
        }
    }

    func makeCountryCardView(country: FavouritesViewModel.CountryViewModel) -> some View {
        HStack {
            RemoteImage(url: country.flag, placeholder: Image(.placholder))
                .frame(width: 40, height: 40)
                .clipShape(Circle())

            Text(country.name)
                .font(Font.gellix(weight: .bold, size: 16))
                .foregroundStyle(DesignSystem.colors.white)

            Spacer()

            IconButton(
                icon: Image(systemName: "star.fill"),
                color: DesignSystem.colors.gold,
                action: {
                    input.removeSavedCountryTapped.send(country)
                }
            )
            .frame(width: 32, height: 32)
        }
        .shadow(color: DesignSystem.colors.black.opacity(0.2), radius: 10, x: 0, y: 20)
        .padding(12)
        .background(DesignSystem.colors.primary)
        .cornerRadius(12)
    }
}
