//
//  GenericView.swift
//  Core
//
//  Created by Taha Mahmoud on 07/01/2025.
//


import SwiftUI

public struct GenericView<
    LoadingView: View,
    ErrorView: View,
    EmptyView: View,
    LoadedView: View
>: View {
    private let state: ViewState
    private let emptyView: () -> EmptyView
    private let errorView: (String?) -> ErrorView
    private let loadingView: () -> LoadingView
    private let loadedView: () -> LoadedView

    public init(
        state: ViewState,
        @ViewBuilder emptyView: @escaping () -> EmptyView,
        @ViewBuilder errorView: @escaping (String?) -> ErrorView,
        @ViewBuilder loadingView: @escaping () -> LoadingView,
        @ViewBuilder loadedView: @escaping () -> LoadedView
    ) {
        self.state = state
        self.emptyView = emptyView
        self.errorView = errorView
        self.loadingView = loadingView
        self.loadedView = loadedView
    }

    public var body: some View {
        VStack(spacing: 0) {
            switch state {
            case .loading:
                loadingView()

            case .empty:
                emptyView()

            case let .error(message):
                errorView(message)

            case .loaded:
                loadedView()
            }
        }
    }
}

extension GenericView where EmptyView == SwiftUI.EmptyView {
    init(
        state: ViewState,
        @ViewBuilder errorView: @escaping (String?) -> ErrorView,
        @ViewBuilder loadingView: @escaping () -> LoadingView,
        @ViewBuilder loadedView: @escaping () -> LoadedView
    ) {
        self.init(
            state: state,
            emptyView: { SwiftUI.EmptyView() },
            errorView: errorView,
            loadingView: loadingView,
            loadedView: loadedView
        )
    }
}

extension GenericView where ErrorView == SwiftUI.EmptyView {
    init(
        state: ViewState,
        @ViewBuilder emptyView: @escaping () -> EmptyView,
        @ViewBuilder loadingView: @escaping () -> LoadingView,
        @ViewBuilder loadedView: @escaping () -> LoadedView
    ) {
        self.init(
            state: state,
            emptyView: emptyView,
            errorView: { _ in SwiftUI.EmptyView() },
            loadingView: loadingView,
            loadedView: loadedView
        )
    }
}

extension GenericView where EmptyView == SwiftUI.EmptyView, ErrorView == SwiftUI.EmptyView {
    init(
        state: ViewState,
        @ViewBuilder loadingView: @escaping () -> LoadingView,
        @ViewBuilder loadedView: @escaping () -> LoadedView
    ) {
        self.init(
            state: state,
            emptyView: { SwiftUI.EmptyView() },
            errorView: { _ in SwiftUI.EmptyView() },
            loadingView: loadingView,
            loadedView: loadedView
        )
    }
}

public enum ViewState: Equatable {
    case loading
    case loaded
    case empty
    case error(message: String?)
}
