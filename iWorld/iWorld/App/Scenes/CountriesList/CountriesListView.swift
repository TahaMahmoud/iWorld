//
//  CountriesListView.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Core
import DesignSystem
import SwiftUI

struct CountriesListView: View {
    @StateObject private var input: CountriesListViewModel.Input
    @StateObject private var output: CountriesListViewModel.Output
    @EnvironmentObject var router: Router

    init(viewModel: CountriesListViewModelProtocol) {
        _input = .init(wrappedValue: viewModel.input)
        _output = .init(wrappedValue: viewModel.output)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            NavigationBarView(
                title: "All Countries",
                backAction: {
                    input.backTapped.send()
                }
            )

            makeSearchBar()

            makeRegionsFilterView()

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
                    makeCountriesListView()
                }
            )

            Spacer()
        }
        .onAppear {
            input.viewOnAppear.send()
        }
        .alert(output.errorMessage, isPresented: $output.showError) {
            Button("OK", role: .cancel) {
                output.showError = false
            }
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
                subtitle: "Try adjusting your search to find what you are looking for"
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

    func makeSearchBar() -> some View {
        HStack(spacing: 8) {
            Image(.icSearch)

            TextField("Find a place to go", text: $input.searchText)
        }
        .padding()
        .background(DesignSystem.colors.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    func makeRegionsFilterView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(output.regions, id: \.self) { region in
                    Button(
                        action: {
                            input.selectedRegion = region
                        },
                        label: {
                            Text(region.rawValue)
                                .font(Font.gellix(
                                    weight: input.selectedRegion == region ? .semiBold : .regular,
                                    size: 14
                                ))
                                .padding(16)
                                .foregroundStyle(
                                    input.selectedRegion == region ? DesignSystem.colors.primary : DesignSystem.colors.primaryGray
                                )
                                .background(
                                    input.selectedRegion == region ? DesignSystem.colors.secondary : .clear
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        })
                }
            }
        }
    }

    func makeCountriesListView() -> some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(output.countries, id: \.id) { country in
                    Button(action: {
                        router.navigate(to: .countryDetails(countryCode: country.id))
                    }, label: {
                        makeCountryCardView(country: country)
                    })
                }
            }
        }
    }

    func makeCountryCardView(country: CountriesListViewModel.CountryViewModel) -> some View {
        HStack {
            RemoteImage(url: country.flag, placeholder: Image(.placholder))
                .frame(width: 40, height: 40)
                .clipShape(Circle())

            Text(country.name)
                .font(Font.gellix(weight: .bold, size: 16))
                .foregroundStyle(DesignSystem.colors.white)

            Spacer()

            IconButton(
                icon: Image(systemName: country.isSaved ? "star.fill" : "star"),
                color: DesignSystem.colors.gold,
                action: {
                    input.saveCountryTapped.send(country)
                }
            )
            .frame(width: 32, height: 32)

            IconButton(
                icon: Image(systemName: country.isHighlighted ? "heart.fill" : "heart"),
                color: DesignSystem.colors.dangor,
                action: {
                    input.highlightCountryTapped.send(country)
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
