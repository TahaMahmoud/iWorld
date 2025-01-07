//
//  RetryPolicy.swift
//
//
//  Created by Taha Mahmoud on 18/01/2024.
//

import Foundation

/// An enumeration representing different retry policies for a remote endpoint.
public enum RetryPolicy {
    /// Never retry the request.
    case neverRetry

    /// Attempt to retry the request within the specified time interval, if it times out.
    case retryOnTimeout(within: TimeInterval)

    /// Attempt to retry the request within the specified time interval, if its response indicates a server error.
    case retryOnServerError(within: TimeInterval)

    /// Attempt to retry the request within the specified time interval,
    /// if it times out or if its response indicates a server error.
    case retryOnServerErrorOrTimeout(within: TimeInterval)

    /// Attempt to retry the request within the specified time interval if any failure occurs.
    case retryOnAnyFailure(within: TimeInterval)
}
