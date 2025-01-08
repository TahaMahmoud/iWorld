//
//  Router.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import SwiftUI

final class Router: ObservableObject {
    public enum Destination: Codable, Hashable {
        case onboarding
        case home
        case countriesList
        case countryDetails(countryCode: String)
        case savedCountries
    }

    @Published var navPath = NavigationPath()

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }

    func navigateBack() {
        navPath.removeLast()
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
