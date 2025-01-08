//
//  CountryDetailsViewModel.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import Combine
import Core
import CoreLocation
import Factory
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
        let saveCountryTapped: AnyUIEvent<Void> = .create()
        let highlightCountryTapped: AnyUIEvent<Void> = .create()
        let showMapTapped: AnyUIEvent<Void> = .create()
    }
}

// MARK: - Output

extension CountryDetailsViewModel {
    class Output: ObservableObject {
        @Published var countryDetails: CountryDetailsViewModel.CountryPresentation?
        @Published var errorMessage: String = ""
        @Published var showError: Bool = false

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
        var isHighlighted: Bool
        var isSaved: Bool
        let borderCountries: [BorderCountryPresentation]
        let location: CLLocationCoordinate2D
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

    @Injected(\.getCountryDetailsUseCase) private var getCountryDetailsUseCase
    @Injected(\.getBordersUseCase) private var getBordersUseCase

    @Injected(\.highlightCountryUseCase) private var highlightCountryUseCase
    @Injected(\.removeHighlightUseCase) private var removeHighlightUseCase
    @Injected(\.isHighlightedUseCase) private var isHighlightedUseCase

    @Injected(\.saveCountryUseCase) private var saveCountryUseCase
    @Injected(\.removeFavouriteUseCase) private var removeFavouriteUseCase
    @Injected(\.isSavedCountryUseCase) private var isSavedUseCase

    init(
        countryCode: String,
        router: RouterProtocol
    ) {
        input = .init()
        output = .init(router: router)
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
            currency: "\(country?.currencies?.first?.name ?? "") (\(country?.currencies?.first?.symbol ?? ""))",
            isHighlighted: isHighlightedUseCase.execute(countryCode: country?.alpha3Code ?? ""),
            isSaved: isSavedUseCase.execute(countryCode: country?.alpha3Code ?? ""),
            borderCountries: mapBorderCountries(
                borderCountries: getBordersUseCase.execute(countryCode: country?.alpha3Code ?? "")
            ),
            location: CLLocationCoordinate2D(
                latitude: country?.latlng?.first ?? 26.8206,
                longitude: country?.latlng?.last ?? 30.8025
            )
        )
    }

    func mapBorderCountries(borderCountries: [Country]) -> [BorderCountryPresentation] {
        borderCountries.map {
            BorderCountryPresentation(id: $0.id, flag: $0.flags?.png ?? "", name: $0.name ?? "")
        }
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

private extension CountryDetailsViewModel {
    func setupObservables() {
        observeAppear()
        observeBackTapped()
        observeBorderCountrySelected()
        observeSaveCountryTapped()
        observeHighlightCountryTap()
        observeShowMapTapped()
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

    func observeSaveCountryTapped() {
        input
            .saveCountryTapped
            .sink { [weak self] _ in
                guard
                    let self,
                    !countryCode.isEmpty
                else { return }

                if output.countryDetails?.isSaved ?? false {
                    removeSavedCountry(countryCode: countryCode)
                } else {
                    saveCountry(countryCode: countryCode)
                }

                output.countryDetails?.isSaved.toggle()
            }
            .store(in: &cancellables)
    }

    func observeHighlightCountryTap() {
        input
            .highlightCountryTapped
            .sink { [weak self] in
                guard
                    let self,
                    !countryCode.isEmpty
                else { return }

                if output.countryDetails?.isHighlighted ?? false {
                    removeHighlitedCountry(countryCode: countryCode)
                } else {
                    highlighCountry(countryCode: countryCode)
                }

                output.countryDetails?.isHighlighted.toggle()
            }
            .store(in: &cancellables)
    }

    func observeShowMapTapped() {
        input
            .showMapTapped
            .sink { [weak self] in
                guard
                    let self,
                    let location = output.countryDetails?.location
                else { return }

                let ountryLocationURL = "https://www.google.com/maps/@\(location.latitude),\(location.longitude),10z"
                URLUtility.openURL(ountryLocationURL)
            }
            .store(in: &cancellables)
    }
}
