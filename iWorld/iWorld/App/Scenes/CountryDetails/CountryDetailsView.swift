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

    init(viewModel: CountryDetailsViewModelProtocol) {
        _input = .init(wrappedValue: viewModel.input)
        _output = .init(wrappedValue: viewModel.output)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack {
                RemoteImage(url: output.countryDetails?.flag ?? "")
                    .frame(height: 300)

                VStack {
                    makeBackButton()

                    Spacer()

                    HStack {
                        IconButton(
                            icon: Image(systemName: output.countryDetails?.isSaved ?? false ? "star.fill" : "star"),
                            color: DesignSystem.colors.gold,
                            action: {
                            }
                        )
                        .frame(width: 44, height: 44)

                        IconButton(
                            icon: Image(systemName: output.countryDetails?.isHighlighted ?? false ? "heart.fill" : "heart"),
                            color: DesignSystem.colors.dangor,
                            action: {
                            }
                        )
                        .frame(width: 44, height: 44)
                    }
                }
            }
            makeCountryDetails()
            makeBorderCountriesView()
        }
        .padding(.horizontal, 20)
        .onAppear(perform: input.viewOnAppear.send)
        .navigationBarHidden(true)
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
        VStack {
            HStack {
                VStack {
                    Text(output.countryDetails?.name ?? "")
                        .font(Font.gellix(weight: .semiBold, size: 24))
                        .foregroundStyle(DesignSystem.colors.black)

                    Text(output.countryDetails?.capital ?? "")
                        .font(Font.gellix(weight: .regular, size: 12))
                        .foregroundStyle(DesignSystem.colors.darkGray)
                }

                Button(action: {
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
        VStack {
            Text(title)
                .font(Font.gellix(weight: .medium, size: 14))
                .foregroundStyle(DesignSystem.colors.black)

            Text(value)
                .font(Font.gellix(weight: .regular, size: 12))
                .foregroundStyle(DesignSystem.colors.darkGray)
        }
    }

    private func makeBorderCountriesView() -> some View {
        ScrollView {
            LazyVStack {
                ForEach(output.countryDetails?.borderCountries ?? [], id: \.id) { country in
                    Button(action: {
                    }, label: {
                        VStack {
                            RemoteImage(url: country.flag)
                                .frame(width: 32, height: 32)
                                .cornerRadius(12)

                            Text(country.name)
                                .font(Font.gellix(weight: .medium, size: 14))
                                .foregroundStyle(DesignSystem.colors.primaryGray)
                        }
                        .padding(12)
                        .cornerRadius(16)
                    })
                }
            }
        }
    }
}
