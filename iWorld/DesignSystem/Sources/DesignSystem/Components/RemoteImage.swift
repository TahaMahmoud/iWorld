//
//  RemoteImage.swift
//
//
//  Created by Taha Mahmoud on 19/01/2024.
//

import SwiftUI

public struct RemoteImage: View {
    public let url: String
    public var placeholder: Image = Image(systemName: "exclamationmark.triangle")
    public var contentMode: ContentMode

    public init(
        url: String,
        placeholder: Image = Image(
            systemName: "exclamationmark.triangle"),
        contentMode: ContentMode = .fill
    ) {
        self.url = url
        self.placeholder = placeholder
        self.contentMode = contentMode
    }

    public var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .background(.clear)
            } else if phase.error != nil {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.red)
            } else {
                ProgressView()
            }
        }
    }
}

#Preview {
    RemoteImage(url: "https://cdn.pixabay.com/photo/2017/02/01/10/00/cartography-2029310_640.png")
}
