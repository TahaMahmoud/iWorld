//
//  HomeViewModel.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Combine
import Core
import CoreLocation
import Factory
import Foundation
import UIKit

protocol HomeViewModelProtocol {
    var input: HomeViewModel.Input { get }
    var output: HomeViewModel.Output { get }
}

// MARK: - Input

extension HomeViewModel {
    class Input: ObservableObject {
        let viewOnAppear: AnyUIEvent<Void> = .create()
        let enableLocationTapped: AnyUIEvent<Void> = .create()
        let countryTapped: AnyUIEvent<CountryViewModel> = .create()
        let removeHighlightTapped: AnyUIEvent<CountryViewModel> = .create()
        let removeSavedTapped: AnyUIEvent<CountryViewModel> = .create()
        let seeAllSavedTapped: AnyUIEvent<Void> = .create()
        let seeAllCountriesTapped: AnyUIEvent<Void> = .create()
    }
}

// MARK: - Output

extension HomeViewModel {
    class Output: ObservableObject {
        @Published var state: ViewState = .loading
        @Published var highlightedCountries: [CountryViewModel] = []
        @Published var savedCountries: [CountryViewModel] = []
        @Published var discoverCountries: [CountryViewModel] = []
        @Published var showSavedCountries: Bool = false
        @Published var showAllCountries: Bool = false
        @Published var selectedCountryCode: String?
        @Published var currentLocation: String?
    }
}

extension HomeViewModel {
    struct CountryViewModel: Identifiable {
        let id: String
        let flag: String
        let name: String
        let capital: String
    }
}

class HomeViewModel: ViewModel, HomeViewModelProtocol {
    public let input: Input
    public let output: Output

    @Injected(\.getCurrentLocationUseCase) private var getCurrentLocationUseCase

    @Injected(\.getHighlightedCountriesUseCase) private var getHighlightedCountriesUseCase
    @Injected(\.removeHighlightUseCase) private var removeHighlightUseCase

    @Injected(\.getSavedCountriesUseCase) private var getSavedCountriesUseCase
    @Injected(\.removeFavouriteUseCase) private var removeFavouriteUseCase

    @Injected(\.getCountriesUseCase) private var getCountriesUseCase

    private var locationDetails: LocationDetails?

    override init() {
        input = .init()
        output = .init()

        super.init()
        setupObservables()
    }

    func loadCountriesData() {
        Task { @MainActor [weak self] in
            guard let self else { return }

            await getCountriesUseCase.execute(limit: nil)
            output.discoverCountries = mapCountries(countries: await getCountriesUseCase.execute(limit: 5))

            await handleLocation()

            output.highlightedCountries = mapCountries(
                countries: getHighlightedCountriesUseCase.execute(currentCountryName: locationDetails?.countryName ?? "")
            )
            output.savedCountries = mapCountries(countries: getSavedCountriesUseCase.execute(limit: 5))

            output.state = .loaded
        }
    }

    func handleLocation() async {
        if Reachability.isConnectedToNetwork() {
            do {
                locationDetails = try await getCurrentLocationUseCase.execute()
                output.currentLocation = "\(locationDetails?.cityName ?? ""), \(locationDetails?.countryName ?? "")"
            } catch {
                output.currentLocation = nil
            }
        }
    }

    func mapCountries(countries: [Country]) -> [CountryViewModel] {
        var mappedCountries: [CountryViewModel] = []

        for country in countries {
            mappedCountries.append(
                CountryViewModel(
                    id: country.id,
                    flag: country.flags?.png ?? "",
                    name: country.name ?? "",
                    capital: country.capital ?? ""
                )
            )
        }

        return mappedCountries
    }

    func removeSavedCountry(countryCode: String) {
        removeFavouriteUseCase.execute(countryCode: countryCode)
    }

    func removeHighlitedCountry(countryCode: String) {
        removeHighlightUseCase.execute(countryCode: countryCode)
    }

    func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}

private extension HomeViewModel {
    func setupObservables() {
        observeAppear()
        observeCountryTapped()
        observeRemoveHighlightTapped()
        observeEnableLocationTapped()
        observeSeeAllSavedTapped()
        observeSeeAllCountriesTapped()
        observeRemoveSavedTapped()
        observeLocationPermissionChange()
    }

    func observeAppear() {
        input
            .viewOnAppear
            .sink { [weak self] in
                guard let self else { return }

                output.state = .loading
                loadCountriesData()
            }
            .store(in: &cancellables)
    }

    func observeCountryTapped() {
        input
            .countryTapped
            .sink { [weak self] country in
                guard
                    let self,
                    !country.id.isEmpty
                else { return }

                output.selectedCountryCode = country.id
            }
            .store(in: &cancellables)
    }

    func observeRemoveHighlightTapped() {
        input
            .removeHighlightTapped
            .sink { [weak self] country in
                guard
                    let self,
                    !country.id.isEmpty
                else { return }

                removeHighlitedCountry(countryCode: country.id)
                loadCountriesData()
            }
            .store(in: &cancellables)
    }

    func observeRemoveSavedTapped() {
        input
            .removeSavedTapped
            .sink { [weak self] country in
                guard
                    let self,
                    !country.id.isEmpty
                else { return }

                removeSavedCountry(countryCode: country.id)
                loadCountriesData()
            }
            .store(in: &cancellables)
    }

    func observeEnableLocationTapped() {
        input
            .enableLocationTapped
            .sink { [weak self] _ in
                guard let self else { return }

                openAppSettings()
            }
            .store(in: &cancellables)
    }

    func observeSeeAllSavedTapped() {
        input
            .seeAllSavedTapped
            .sink { [weak self] _ in
                guard let self else { return }

                output.showSavedCountries = true
            }
            .store(in: &cancellables)
    }

    func observeSeeAllCountriesTapped() {
        input
            .seeAllCountriesTapped
            .sink { [weak self] _ in
                guard let self else { return }

                output.showAllCountries = true
            }
            .store(in: &cancellables)
    }

    func observeLocationPermissionChange() {
        LocationManager.shared
            .$authorisationStatus
            .sink { [weak self] _ in
                guard let self else { return }

                loadCountriesData()
            }
            .store(in: &cancellables)
    }
}
