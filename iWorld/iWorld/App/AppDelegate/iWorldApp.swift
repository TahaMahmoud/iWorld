//
//  iWorldApp.swift
//  iWorld
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import SwiftUI
import DesignSystem
import Core
import Logger

@main
struct IMoviesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var router: Router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                OnboardingView()
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .onboarding:
                        OnboardingView()
                    case .home:
                        EmptyView()
                    case .countriesList:
                        CountriesListView(viewModel: CountriesListViewModel(router: router))
                    case let .countryDetails(countryCode):
                        CountryDetailsView(viewModel: CountryDetailsViewModel(countryCode: countryCode, router: router))
                    case .savedCountries:
                        EmptyView()
                    }
                }
            }
            .environmentObject(router)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    static var shared: AppDelegate!

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [
            UIApplication.LaunchOptionsKey: Any
        ]? = nil) -> Bool {
            Self.shared = self
            setup()
        return true
    }

    func setup() {
        _ = [
            LoggerManager.shared,
            UIInitializer.shared,
            DesignSystemConfigurator.shared
        ].map { $0.setup() }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        listenForUpdates()
    }

    func listenForUpdates() {
    }
}
