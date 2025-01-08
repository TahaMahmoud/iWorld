//
//  CountriesListViewModel.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Combine
import Core
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

        let router: RouterProtocol

        init(router: RouterProtocol) {
            self.router = router
        }
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

    private let getCountriesUseCase: GetCountriesUseCaseProtocol
    private let getRegionsUseCase: GetRegionsUseCaseProtocol

    private let highlightCountryUseCase: HighlightCountryUseCaseProtocol
    private let removeHighlightUseCase: RemoveHighlightUseCaseProtocol
    private let isHighlightedUseCase: IsHighlighedUseCaseProtocol

    private let saveCountryUseCase: SaveCountryUseCaseProtocol
    private let removeFavouriteUseCase: RemoveFavouriteUseCaseProtocol
    private let isSavedUseCase: IsSavedCountryUseCaseProtocol

    init(
        router: RouterProtocol,
        getCountriesUseCase: GetCountriesUseCaseProtocol = DIContainer.getCountriesUseCase,
        getRegionsUseCase: GetRegionsUseCaseProtocol = DIContainer.getRegionsUseCase,
        highlightCountryUseCase: HighlightCountryUseCaseProtocol = DIContainer.highlightCountryUseCase,
        removeHighlightUseCase: RemoveHighlightUseCaseProtocol = DIContainer.removeHighlightUseCase,
        isHighlightedUseCase: IsHighlighedUseCaseProtocol = DIContainer.isHighlighedUseCase,
        saveCountryUseCase: SaveCountryUseCaseProtocol = DIContainer.saveCountryUseCase,
        removeFavouriteUseCase: RemoveFavouriteUseCaseProtocol = DIContainer.removeFavouriteUseCase,
        isSavedUseCase: IsSavedCountryUseCaseProtocol = DIContainer.isSavedCountryUseCase
    ) {
        input = .init()
        output = .init(router: router)

        self.getCountriesUseCase = getCountriesUseCase
        self.getRegionsUseCase = getRegionsUseCase
        self.highlightCountryUseCase = highlightCountryUseCase
        self.removeHighlightUseCase = removeHighlightUseCase
        self.isHighlightedUseCase = isHighlightedUseCase
        self.saveCountryUseCase = saveCountryUseCase
        self.removeFavouriteUseCase = removeFavouriteUseCase
        self.isSavedUseCase = isSavedUseCase

        super.init()
        setupObservables()
    }

    func getCountriesData() {
        output.state = .loading

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
}

private extension CountriesListViewModel {
    func setupObservables() {
        observeAppear()
        observeBackTapped()
        observeRegionChanged()
        observeSearchTextChanged()
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

                getCountriesData()
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
}
