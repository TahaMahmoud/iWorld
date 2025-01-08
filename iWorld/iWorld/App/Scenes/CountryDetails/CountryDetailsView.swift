//
//  CountryDetailsView.swift
//  iWorld
//
//  Created by Taha Mahmoud on 08/01/2025.
//

import DesignSystem
import SwiftUI

struct CountryDetailsView: View {
    @StateObject private var input: CountryDetailsViewModel.Input
    @StateObject private var output: CountryDetailsViewModel.Output
    @EnvironmentObject var router: Router

    init(viewModel: CountryDetailsViewModelProtocol) {
        _input = .init(wrappedValue: viewModel.input)
        _output = .init(wrappedValue: viewModel.output)
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                makeBackButton()
                Spacer()

                IconButton(
                    icon: Image(systemName: output.countryDetails?.isSaved ?? false ? "star.fill" : "star"),
                    color: DesignSystem.colors.gold,
                    padding: 12,
                    action: {
                        input.saveCountryTapped.send()
                    }
                )
                .frame(width: 44, height: 44)

                IconButton(
                    icon: Image(systemName: output.countryDetails?.isHighlighted ?? false ? "heart.fill" : "heart"),
                    color: DesignSystem.colors.dangor,
                    padding: 12,
                    action: {
                        input.highlightCountryTapped.send()
                    }
                )
                .frame(width: 44, height: 44)
            }

            RemoteImage(url: output.countryDetails?.flag ?? "", contentMode: .fit)
                .cornerRadius(16)
                .shadow(color: DesignSystem.colors.black.opacity(0.1), radius: 16, x: 0, y: 10)
                .frame(height: 300)

            makeCountryDetails()

            Text("Borders")
                .font(Font.gellix(weight: .semiBold, size: 24))
                .foregroundStyle(DesignSystem.colors.black)
                .padding(.top, 16)

            makeBorderCountriesView()

            Spacer()
        }
        .alert(output.errorMessage, isPresented: $output.showError) {
            Button("OK", role: .cancel) {
                output.showError = false
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 20)
        .onAppear(perform: input.viewOnAppear.send)
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

    private func makeBackButton() -> some View {
        Button(
            action: input.backTapped.send
        ) {
            Image(.icBack)
                .frame(width: 40, height: 40)
                .background(DesignSystem.colors.secondary)
                .cornerRadius(8)
        }
    }

    private func makeCountryDetails() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading) {
                    Text(output.countryDetails?.name ?? "")
                        .font(Font.gellix(weight: .semiBold, size: 24))
                        .foregroundStyle(DesignSystem.colors.black)

                    Text(output.countryDetails?.capital ?? "")
                        .font(Font.gellix(weight: .regular, size: 14))
                        .foregroundStyle(DesignSystem.colors.darkGray)
                }

                Spacer()

                Button(action: {
                    input.showMapTapped.send()
                }, label: {
                    Text("Show Map")
                        .font(Font.gellix(weight: .bold, size: 14))
                        .foregroundStyle(DesignSystem.colors.primary)
                })
            }

            makeTitleValueView(
                title: "Region",
                value: output.countryDetails?.region ?? ""
            )
            makeTitleValueView(
                title: "Currency",
                value: output.countryDetails?.currency ?? ""
            )
        }
    }

    private func makeTitleValueView(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(Font.gellix(weight: .medium, size: 14))
                .foregroundStyle(DesignSystem.colors.black)

            Text(value)
                .font(Font.gellix(weight: .regular, size: 12))
                .foregroundStyle(DesignSystem.colors.darkGray)
        }
    }

    private func makeBorderCountriesView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(output.countryDetails?.borderCountries ?? [], id: \.id) { country in
                    Button(action: {
                        input.borderCountrySelected.send(country.id)
                    }, label: {
                        VStack {
                            RemoteImage(url: country.flag)
                                .frame(width: 32, height: 32)
                                .cornerRadius(12)

                            Text(country.name)
                                .font(Font.gellix(weight: .medium, size: 14))
                                .foregroundStyle(DesignSystem.colors.primaryGray)
                                .lineLimit(1)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .background(DesignSystem.colors.secondary)
                        .cornerRadius(16)
                        .frame(maxWidth: 140)
                    })
                }
            }
        }
    }
}
