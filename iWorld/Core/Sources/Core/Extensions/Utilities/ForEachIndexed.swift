//
//  ForEachIndexed.swift
//  Core
//
//  Created by Taha Mahmoud on 07/01/2025.
//

import SwiftUI

// swiftlint:disable:next identifier_name
public func ForEachIndexed<Data: RandomAccessCollection, Content: View>(
    _ data: Data,
    @ViewBuilder content: @escaping (Data.Index, Data.Element) -> Content
) -> some View where Data.Element: Identifiable, Data.Element: Hashable {
    ForEach(Array(zip(data.indices, data)), id: \.1.id) { index, element in
        content(index, element)
    }
}
