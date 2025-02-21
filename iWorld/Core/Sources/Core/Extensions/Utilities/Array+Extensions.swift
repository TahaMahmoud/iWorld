//
//  Array+Extensions.swift
//  Core
//
//  Created by Taha Mahmoud on 07/01/2025.
//


extension Array {
    /// Safely retrieves an element at the specified index if it is within the array's bounds.
    ///
    /// - Parameter safe: The index to access safely.
    /// - Returns: The element at the specified index in case of  it exists, or `nil` if the index is out of bounds.
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
