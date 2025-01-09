//
//  HomeView.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Core
import DesignSystem
import SwiftUI

struct HomeView: View {
    @StateObject private var input: HomeViewModel.Input
    @StateObject private var output: HomeViewModel.Output
    @EnvironmentObject var router: Router

    init(viewModel: HomeViewModelProtocol) {
        _input = .init(wrappedValue: viewModel.input)
        _output = .init(wrappedValue: viewModel.output)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            makeNavigationBarView()

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
                    makeHomeView()
                }
            )

            Spacer()
        }
        .onAppear {
            input.viewOnAppear.send()
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .navigationBarHidden(true)
        .onReceive(output.$showAllCountries) { showAllCountries in
            if showAllCountries {
                router.navigate(to: .countriesList)
            }
        }
        .onReceive(output.$showSavedCountries) { showSavedCountries in
            if showSavedCountries {
                router.navigate(to: .savedCountries)
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
        VStack(spacing: 16) {
            ShimmerRectangularView()
                .frame(height: 200)

            ShimmerRectangularView()
                .frame(height: 200)

            ShimmerRectangularView()
                .frame(height: 200)
        }
    }

    private func makeNavigationBarView() -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("EXPLORE")
                    .font(Font.gellix(weight: .regular, size: 14))
                    .foregroundStyle(DesignSystem.colors.black)

                Text("iWORLD")
                    .font(Font.gellix(weight: .medium, size: 32))
                    .foregroundStyle(DesignSystem.colors.black)
            }

            Spacer()

            Button(action: {
                if output.currentLocation == nil {
                    input.enableLocationTapped.send()
                }
            }, label: {
                HStack {
                    Image(.icLocation)
                        .resizable()
                        .frame(width: 16, height: 16)

                    Text((output.currentLocation == nil ? "Enable Location" : output.currentLocation) ?? "")
                        .font(Font.gellix(weight: .regular, size: 12))
                        .foregroundStyle(DesignSystem.colors.primaryGray)

                    Image(.icArrowRight)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .isHidden(output.currentLocation != nil, remove: true)

                    Image(.icArrowRight)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .isHidden(output.currentLocation == nil, remove: true)
                }
            })
        }
    }

    private func makeHomeView() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                makeHighlighedSectionView()

                makeSavedSectionView()

                makeDiscoverSectionView()
            }
        }
    }

    private func makeHighlighedSectionView() -> some View {
        VStack(alignment: .leading) {
            Text("Highlighted")
                .font(Font.gellix(weight: .semiBold, size: 18))
                .foregroundStyle(DesignSystem.colors.black)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(output.highlightedCountries, id: \.id) { country in
                        Button(action: {
                            input.countryTapped.send(country)
                        }, label: {
                            makeHighlightedCountryView(country: country)
                                .cornerRadius(16)
                                .frame(height: 200)
                                .shadow(color: DesignSystem.colors.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        })
                    }
                }
            }
        }
    }

    private func makeHighlightedCountryView(country: HomeViewModel.CountryViewModel) -> some View {
        ZStack(alignment: .bottom) {
            RemoteImage(url: country.flag, contentMode: .fill)
                .frame(
                    width: output.highlightedCountries.count < 2 ? UIScreen.main.bounds.width - 48 : 180
                )
                .cornerRadius(16)

            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(country.name.prefix(10))
                        .font(Font.gellix(weight: .regular, size: 12))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .foregroundStyle(DesignSystem.colors.white)
                        .background(DesignSystem.colors.darkGray)
                        .clipShape(Capsule())

                    HStack(spacing: 5) {
                        Image(.icLocationGold)
                            .frame(width: 16, height: 16)

                        Text(country.capital.prefix(10))
                            .font(Font.gellix(weight: .regular, size: 12))
                            .foregroundStyle(DesignSystem.colors.white)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(DesignSystem.colors.darkGray)
                    .clipShape(Capsule())

                }
                .lineLimit(1)
                .padding(.bottom, 30)

                Spacer()

                IconButton(
                    icon: Image(systemName: "heart.fill"),
                    color: DesignSystem.colors.dangor,
                    padding: 6,
                    action: {
                        input.removeHighlightTapped.send(country)
                    }
                )
                .isHidden(output.highlightedCountries.count < 2, remove: true)
                .frame(width: 30, height: 30)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 16)
        }
    }

    private func makeSavedSectionView() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Saved")
                    .font(Font.gellix(weight: .semiBold, size: 18))
                    .foregroundStyle(DesignSystem.colors.black)

                Spacer()

                Button(action: {
                    input.seeAllSavedTapped.send()
                }, label: {
                    Text("See All")
                        .font(Font.gellix(weight: .medium, size: 12))
                        .foregroundStyle(DesignSystem.colors.primary)
                })
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(output.savedCountries, id: \.id) { country in
                        Button(action: {
                            input.countryTapped.send(country)
                        }, label: {
                            makeCountryView(country: country, isSaved: true)
                                .frame(height: 160)
                                .cornerRadius(16)
                                .shadow(color: DesignSystem.colors.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        })
                    }
                }
            }
        }
        .isHidden(output.savedCountries.isEmpty, remove: true)
    }

    private func makeCountryView(country: HomeViewModel.CountryViewModel, isSaved: Bool) -> some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottom) {
                RemoteImage(url: country.flag, contentMode: .fill)
                    .frame(width: 170)
                    .cornerRadius(16)

                VStack {
                    HStack {
                        Spacer()

                        IconButton(
                            icon: Image(systemName: "star.fill"),
                            color: DesignSystem.colors.gold,
                            padding: 6,
                            action: {
                                input.removeSavedTapped.send(country)
                            }
                        )
                        .frame(width: 30, height: 30)
                    }

                    Spacer()
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
                .isHidden(!isSaved, remove: true)
            }

            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(country.name.prefix(10))
                        .font(Font.gellix(weight: .medium, size: 14))
                        .foregroundStyle(DesignSystem.colors.black)

                    HStack(spacing: 3) {
                        Image(.icLocation)
                            .resizable()
                            .frame(width: 16, height: 16)

                        Text(country.capital.prefix(10))
                            .font(Font.gellix(weight: .regular, size: 10))
                            .foregroundStyle(DesignSystem.colors.darkGray)
                    }
                }
                .lineLimit(1)

                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 16)
        }
    }

    private func makeDiscoverSectionView() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Discover")
                    .font(Font.gellix(weight: .semiBold, size: 18))
                    .foregroundStyle(DesignSystem.colors.black)

                Spacer()

                Button(action: {
                    input.seeAllCountriesTapped.send()
                }, label: {
                    Text("See All")
                        .font(Font.gellix(weight: .medium, size: 12))
                        .foregroundStyle(DesignSystem.colors.primary)
                })
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(output.discoverCountries, id: \.id) { country in
                        Button(action: {
                            input.countryTapped.send(country)
                        }, label: {
                            makeCountryView(country: country, isSaved: false)
                                .frame(height: 160)
                                .cornerRadius(16)
                                .shadow(color: DesignSystem.colors.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        })
                    }
                }
            }
        }
    }
}
