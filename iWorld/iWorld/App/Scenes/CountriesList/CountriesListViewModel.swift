//
//  CountriesListViewModel.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Combine
import Core
import Factory
import Foundation

protocol CountriesListViewModelProtocol {
    var input: CountriesListViewModel.Input { get }
    var output: CountriesListViewModel.Output { get }
}

// MARK: - Input

extension CountriesListViewModel {
    class Input: ObservableObject {
        let viewOnAppear: AnyUIEvent<Void> = .create()
        let backTapped: AnyUIEvent<Void> = .create()
        let countryTapped: AnyUIEvent<String?> = .create()
        let saveCountryTapped: AnyUIEvent<CountryViewModel> = .create()
        let highlightCountryTapped: AnyUIEvent<CountryViewModel> = .create()
        @Published var searchText: String = ""
        @Published var selectedRegion: Region = .africa
    }
}

// MARK: - Output

extension CountriesListViewModel {
    class Output: ObservableObject {
        @Published var state: ViewState = .loading
        @Published var countries: [CountryViewModel] = []
        @Published var regions: [Region] = []
        @Published var errorMessage: String = ""
        @Published var showError: Bool = false
        @Published var shouldBack: Bool = false
        @Published var selectedCountryCode: String?
    }
}

extension CountriesListViewModel {
    struct CountryViewModel: Identifiable {
        let id: String
        let flag: String
        let name: String
        let isHighlighted: Bool
        let isSaved: Bool
    }
}

class CountriesListViewModel: ViewModel, CountriesListViewModelProtocol {
    public let input: Input
    public let output: Output

    @Injected(\.getCountriesUseCase) private var getCountriesUseCase
    @Injected(\.getRegionsUseCase) private var getRegionsUseCase

    @Injected(\.highlightCountryUseCase) private var highlightCountryUseCase
    @Injected(\.removeHighlightUseCase) private var removeHighlightUseCase
    @Injected(\.isHighlightedUseCase) private var isHighlightedUseCase

    @Injected(\.saveCountryUseCase) private var saveCountryUseCase
    @Injected(\.removeFavouriteUseCase) private var removeFavouriteUseCase
    @Injected(\.isSavedCountryUseCase) private var isSavedUseCase

    override init() {
        input = .init()
        output = .init()

        super.init()
        setupObservables()
    }

    func loadCountriesData() {
        Task { @MainActor [weak self] in
            guard let self else { return }

            output.regions = getRegionsUseCase.execute()
            await getCountriesUseCase.execute(limit: nil)
            output.countries = mapCountries(countries: getCountriesUseCase.execute(region: input.selectedRegion))

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
                    name: country.name ?? "",
                    isHighlighted: isHighlightedUseCase.execute(countryCode: country.alpha3Code ?? ""),
                    isSaved: isSavedUseCase.execute(countryCode: country.alpha3Code ?? "")
                )
            )
        }

        return mappedCountries
    }

    func saveCountry(countryCode: String) {
        saveCountryUseCase.execute(countryCode: countryCode)
    }

    func removeSavedCountry(countryCode: String) {
        removeFavouriteUseCase.execute(countryCode: countryCode)
    }

    func highlighCountry(countryCode: String) {
        do {
            try highlightCountryUseCase.execute(countryCode: countryCode)
        } catch let error {
            if case AppError.highlightsLimitExceeded = error {
                output.errorMessage = "Limit of highlighted countries reached"
                output.showError = true
            }
        }
    }

    func removeHighlitedCountry(countryCode: String) {
        removeHighlightUseCase.execute(countryCode: countryCode)
    }
}

private extension CountriesListViewModel {
    func setupObservables() {
        observeAppear()
        observeBackTapped()
        observeRegionChanged()
        observeSearchTextChanged()
        observeCountryTapped()
        observeSaveCountryTapped()
        observeHighlightCountryTap()
    }

    func observeBackTapped() {
        input
            .backTapped
            .sink { [weak self] in
                guard let self else { return }

                output.shouldBack = true
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

    func observeRegionChanged() {
        input
            .$selectedRegion
            .sink { [weak self] region in
                guard let self else { return }

                output.countries = mapCountries(countries: getCountriesUseCase.execute(region: region))
                output.state = output.countries.isEmpty ? .empty : .loaded
            }
            .store(in: &cancellables)
    }

    func observeSearchTextChanged() {
        input
            .$searchText
            .sink { [weak self] query in
                guard
                    let self,
                    !query.isEmpty
                else { return }

                output.countries = mapCountries(countries: getCountriesUseCase.execute(
                    query: query,
                    region: input.selectedRegion
                ))

                output.state = output.countries.isEmpty ? .empty : .loaded
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

                output.selectedCountryCode = countryCode
            }
            .store(in: &cancellables)
    }

    func observeSaveCountryTapped() {
        input
            .saveCountryTapped
            .sink { [weak self] country in
                guard
                    let self,
                    !country.id.isEmpty
                else { return }

                if country.isSaved {
                    removeSavedCountry(countryCode: country.id)
                } else {
                    saveCountry(countryCode: country.id)
                }

                loadCountriesData()
            }
            .store(in: &cancellables)
    }

    func observeHighlightCountryTap() {
        input
            .highlightCountryTapped
            .sink { [weak self] country in
                guard
                    let self,
                    !country.id.isEmpty
                else { return }

                if country.isHighlighted {
                    removeHighlitedCountry(countryCode: country.id)
                } else {
                    highlighCountry(countryCode: country.id)
                }

                loadCountriesData()
            }
            .store(in: &cancellables)
    }
}
