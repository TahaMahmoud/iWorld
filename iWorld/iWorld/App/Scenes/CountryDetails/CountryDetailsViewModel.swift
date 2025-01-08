//
//  CountryDetailsViewModel.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Combine
import Core
import Foundation

protocol CountryDetailsViewModelProtocol {
    var input: CountryDetailsViewModel.Input { get }
    var output: CountryDetailsViewModel.Output { get }
}

// MARK: - Input

extension CountryDetailsViewModel {
    class Input: ObservableObject {
        let viewOnAppear: AnyUIEvent<Void> = .create()
        let backTapped: AnyUIEvent<Void> = .create()
        let borderCountrySelected: AnyUIEvent<String> = .create()
    }
}

// MARK: - Output

extension CountryDetailsViewModel {
    class Output: ObservableObject {
        @Published var countryDetails: CountryDetailsViewModel.CountryPresentation?

        let router: RouterProtocol

        init(router: RouterProtocol) {
            self.router = router
        }
    }
}

extension CountryDetailsViewModel {
    struct CountryPresentation: Identifiable {
        let id: String
        let flag: String
        let name: String
        let capital: String
        let region: String
        let currency: String
        let isHighlighted: Bool
        let isSaved: Bool
        let borderCountries: [BorderCountryPresentation]
    }

    struct BorderCountryPresentation: Identifiable {
        let id: String
        let flag: String
        let name: String
    }
}

class CountryDetailsViewModel: ViewModel, CountryDetailsViewModelProtocol {
    public let input: Input
    public let output: Output

    private let countryCode: String

    private let getCountryDetailsUseCase: GetCountryDetailsUseCaseProtocol
    private let getBordersUseCase: GetBordersUseCaseProtocol

    private let highlightCountryUseCase: HighlightCountryUseCaseProtocol
    private let removeHighlightUseCase: RemoveHighlightUseCaseProtocol
    private let isHighlightedUseCase: IsHighlighedUseCaseProtocol

    private let saveCountryUseCase: SaveCountryUseCaseProtocol
    private let removeFavouriteUseCase: RemoveFavouriteUseCaseProtocol
    private let isSavedUseCase: IsSavedCountryUseCaseProtocol

    init(
        countryCode: String,
        router: RouterProtocol,
        getCountryDetailsUseCase: GetCountryDetailsUseCaseProtocol = DIContainer.getCountryDetailsUseCase,
        highlightCountryUseCase: HighlightCountryUseCaseProtocol = DIContainer.highlightCountryUseCase,
        removeHighlightUseCase: RemoveHighlightUseCaseProtocol = DIContainer.removeHighlightUseCase,
        isHighlightedUseCase: IsHighlighedUseCaseProtocol = DIContainer.isHighlighedUseCase,
        saveCountryUseCase: SaveCountryUseCaseProtocol = DIContainer.saveCountryUseCase,
        removeFavouriteUseCase: RemoveFavouriteUseCaseProtocol = DIContainer.removeFavouriteUseCase,
        isSavedUseCase: IsSavedCountryUseCaseProtocol = DIContainer.isSavedCountryUseCase,
        getBordersUseCase: GetBordersUseCaseProtocol = DIContainer.getBordersUseCase
    ) {
        input = .init()
        output = .init(router: router)

        self.getCountryDetailsUseCase = getCountryDetailsUseCase
        self.highlightCountryUseCase = highlightCountryUseCase
        self.removeHighlightUseCase = removeHighlightUseCase
        self.isHighlightedUseCase = isHighlightedUseCase
        self.saveCountryUseCase = saveCountryUseCase
        self.removeFavouriteUseCase = removeFavouriteUseCase
        self.isSavedUseCase = isSavedUseCase
        self.getBordersUseCase = getBordersUseCase
        self.countryCode = countryCode

        super.init()
        setupObservables()
    }

    func getCountryDetails() {
        let countryDetails = getCountryDetailsUseCase.execute(countyCode: countryCode)
        output.countryDetails = mapCountry(country: countryDetails)
    }

    func mapCountry(country: Country?) -> CountryPresentation {
        CountryPresentation(
            id: country?.id ?? "",
            flag: country?.flags?.png ?? "",
            name: country?.name ?? "",
            capital: country?.capital ?? "",
            region: country?.region?.rawValue ?? "",
            currency: "\(country?.currencies?.first?.name ?? "") (\(country?.currencies?.first?.symbol ?? "")",
            isHighlighted: isHighlightedUseCase.execute(countryCode: country?.alpha3Code ?? ""),
            isSaved: isSavedUseCase.execute(countryCode: country?.alpha3Code ?? ""),
            borderCountries: mapBorderCountries(
                borderCountries: getBordersUseCase.execute(countryCode: country?.alpha3Code ?? "")
            )
        )
    }

    func mapBorderCountries(borderCountries: [Country]) -> [BorderCountryPresentation] {
        borderCountries.map {
            BorderCountryPresentation(id: $0.id, flag: $0.flags?.png ?? "", name: $0.name ?? "")
        }
    }
}

private extension CountryDetailsViewModel {
    func setupObservables() {
        observeAppear()
        observeBackTapped()
        observeBorderCountrySelected()
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

                getCountryDetails()
            }
            .store(in: &cancellables)
    }

    func observeBorderCountrySelected() {
        input
            .borderCountrySelected
            .sink { [weak self] countryCode in
                guard
                    let self,
                        !countryCode.isEmpty
                else { return }
                
                output.router.navigate(to: .countryDetails(countryCode: countryCode))
            }
            .store(in: &cancellables)
    }
}
