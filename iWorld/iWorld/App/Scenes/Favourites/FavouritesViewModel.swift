//
//  FavouritesViewModel.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Combine
import Core
import Factory
import Foundation

protocol FavouritesViewModelProtocol {
    var input: FavouritesViewModel.Input { get }
    var output: FavouritesViewModel.Output { get }
}

// MARK: - Input

extension FavouritesViewModel {
    class Input: ObservableObject {
        let viewOnAppear: AnyUIEvent<Void> = .create()
        let backTapped: AnyUIEvent<Void> = .create()
        let countryTapped: AnyUIEvent<String?> = .create()
        let removeSavedCountryTapped: AnyUIEvent<CountryViewModel> = .create()
    }
}

// MARK: - Output

extension FavouritesViewModel {
    class Output: ObservableObject {
        @Published var state: ViewState = .loading
        @Published var countries: [CountryViewModel] = []

        let router: RouterProtocol

        init(router: RouterProtocol) {
            self.router = router
        }
    }
}

extension FavouritesViewModel {
    struct CountryViewModel: Identifiable {
        let id: String
        let flag: String
        let name: String
    }
}

class FavouritesViewModel: ViewModel, FavouritesViewModelProtocol {
    public let input: Input
    public let output: Output

    @Injected(\.getSavedCountriesUseCase) private var getSavedCountriesUseCase
    @Injected(\.removeFavouriteUseCase) private var removeFavouriteUseCase

    init(router: RouterProtocol) {
        input = .init()
        output = .init(router: router)

        super.init()
        setupObservables()
    }

    func loadCountriesData() {
        Task { @MainActor [weak self] in
            guard let self else { return }

            output.countries = mapCountries(countries: getSavedCountriesUseCase.execute(limit: nil))
            output.state = output.countries.isEmpty ? .empty : .loaded
        }
    }

    func mapCountries(countries: [Country]) -> [CountryViewModel] {
        var mappedCountries: [CountryViewModel] = []

        for country in countries {
            mappedCountries.append(
                CountryViewModel(
                    id: country.id,
                    flag: country.flags?.png ?? "",
                    name: country.name ?? ""
                )
            )
        }

        return mappedCountries
    }

    func removeSavedCountry(countryCode: String) {
        removeFavouriteUseCase.execute(countryCode: countryCode)
    }
}

private extension FavouritesViewModel {
    func setupObservables() {
        observeAppear()
        observeBackTapped()
        observeCountryTapped()
        observeRemoveSavedCountryTapped()
    }

    func observeBackTapped() {
        input
            .backTapped
            .sink { [weak self] in
                guard let self else { return }

                output.router.navigateBack()
            }
            .store(in: &cancellables)
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
            .sink { [weak self] countryCode in
                guard
                    let self,
                    let countryCode, !countryCode.isEmpty
                else { return }

                output.router.navigate(to: .countryDetails(countryCode: countryCode))
            }
            .store(in: &cancellables)
    }

    func observeRemoveSavedCountryTapped() {
        input
            .removeSavedCountryTapped
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
}
