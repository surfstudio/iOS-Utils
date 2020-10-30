//
//  MultiStatesPresentable.swift
//  Utils
//
//  Created by Никита Гагаринов on 18.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

public protocol MultiStatesPresentable {
    var useTopSafeArea: Bool { get }
    var containerView: UIView { get }
    /// Adjusting the top padding of LoadingView
    var sharedLoadingTopOffset: CGFloat? { get }
    /// Adjusting the top padding of Error/EmptyView
    var sharedErrorTopOffset: CGFloat? { get }

    /// If the callback parameter is specified, then only callback will be called on the action
    /// If it is nil, then the corresponding performErrorStateAction / performEmptyStateAction method will be called
    func showErrorView(info: ViewStateInfo, config: ViewStateConfiguration, _ callback: (() -> Void)?)
    func showEmptyView(info: ViewStateInfo, config: ViewStateConfiguration, _ callback: (() -> Void)?)
    func showLoaderView()

    func hideErrorView()
    func hideEmptyView()
    func hideLoaderView()

    /// They are called by default for actions, except when the callback is specified in the calling methods
    func performErrorStateAction()
    func performEmptyStateAction()
}

public extension MultiStatesPresentable where Self: UIViewController {

    var containerView: UIView {
        return view
    }

    var useTopSafeArea: Bool {
        return true
    }

    var sharedLoadingTopOffset: CGFloat? {
        return nil
    }

    var sharedErrorTopOffset: CGFloat? {
        return nil
    }

    var viewFrame: CGRect {
        guard let topOffset = sharedLoadingTopOffset else {
            return containerView.bounds
        }
        var frame = containerView.bounds
        frame.origin.y += topOffset
        frame.size.height -= topOffset
        return frame
    }

    private var loaderView: BaseLoadingView? {
        return containerView.subviews.first { $0 is BaseLoadingView } as? BaseLoadingView
    }

    private var errorView: ErrorView? {
        let errorView = containerView.subviews.first { ($0 as? ErrorView)?.state == .error }
        return errorView as? ErrorView
    }

    private var emptyView: ErrorView? {
        let emptyView = containerView.subviews.first { ($0 as? ErrorView)?.state == .empty }
        return emptyView as? ErrorView
    }

    func showEmptyView(info: ViewStateInfo, config: ViewStateConfiguration, _ callback: (() -> Void)?) {
        guard emptyView == nil else {
            emptyView?.configure(info: info, config: config, state: .empty)
            return
        }
        createView(with: .empty, info: info, config: config, callback: callback)
    }

    func showErrorView(info: ViewStateInfo, config: ViewStateConfiguration, _ callback: (() -> Void)?) {
        guard emptyView == nil else {
            emptyView?.configure(info: info, config: config, state: .error)
            return
        }
        createView(with: .error, info: info, config: config, callback: callback)
    }

    func showLoaderView() {
        guard let provider = self as? LoadingDataProvider else {
            return
        }
        guard loaderView == nil else {
            loaderView?.configure(blocks: provider.getBlocks(), config: provider.config)
            loaderView?.setNeedAnimating(true)
            return
        }

        let loadingView = BaseLoadingView(frame: viewFrame)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.backgroundColor = containerView.backgroundColor
        loadingView.configure(blocks: provider.getBlocks(), config: provider.config)
        loadingView.clipsToBounds = true
        containerView.addSubview(loadingView)
        containerView.bringSubviewToFront(loadingView)

        strecth(view: loadingView)

        // Workaround. When called from viewDidLoad for the first time the shimmer runs to the middle of the screen
        // and looks like a buggy shimer, so at least everything is nice
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            loadingView.setNeedAnimating(true)
        }

        updateContainerState()
    }

    func hideErrorView() {
        errorView?.removeFromSuperview()
        updateContainerState()
    }

    func hideEmptyView() {
        emptyView?.removeFromSuperview()
        updateContainerState()
    }

    func hideLoaderView() {
        loaderView?.removeFromSuperview()
        updateContainerState()
    }

    // Implemented in your controller if needed
    func performErrorStateAction() {}
    func performEmptyStateAction() {}

}

public extension MultiStatesPresentable where Self: UIView {

    var useTopSafeArea: Bool {
        return false
    }

    var containerView: UIView {
        return self
    }

    var sharedLoadingTopOffset: CGFloat? {
        return nil
    }

    var sharedErrorTopOffset: CGFloat? {
        return nil
    }

    private var loaderView: BaseLoadingView? {
        return containerView.subviews.first { $0 is BaseLoadingView } as? BaseLoadingView
    }

    private var errorView: ErrorView? {
        let errorView = containerView.subviews.first { ($0 as? ErrorView)?.state == .error }
        return errorView as? ErrorView
    }

    private var emptyView: ErrorView? {
        let emptyView = containerView.subviews.first { ($0 as? ErrorView)?.state == .empty }
        return emptyView as? ErrorView
    }

    func showLoaderView() {
        guard let provider = self as? LoadingDataProvider else {
            return
        }
        guard loaderView == nil else {
            loaderView?.configure(blocks: provider.getBlocks(), config: provider.config)
            loaderView?.setNeedAnimating(true)
            return
        }

        addLoadingView(blocks: provider.getBlocks(), config: provider.config)
        updateContainerState()
    }

    func hideLoaderView() {
        loaderView?.removeFromSuperview()
        updateContainerState()
    }

    func showErrorView(info: ViewStateInfo, _ callback: (() -> Void)?) {}
    func hideErrorView() {}
    func showEmptyView(info: ViewStateInfo, _ callback: (() -> Void)?) {}
    func hideEmptyView() {}
    func performErrorStateAction() {}
    func performEmptyStateAction() {}

}

// MARK: - Support

private extension MultiStatesPresentable where Self: UIViewController {

    func updateContainerState() {
        guard containerView != view else {
            return
        }
        containerView.isUserInteractionEnabled = !containerView.subviews.isEmpty
    }

    func createView(with type: ErrorViewState,
                    info: ViewStateInfo,
                    config: ViewStateConfiguration,
                    callback: (() -> Void)?) {
        let errorView: ErrorView
        if let provider = self as? ErrorDataProvider {
            errorView = provider.errorView
        } else {
            errorView = DefaultErrorView(frame: viewFrame)
        }
        errorView.configure(info: info, config: config, state: type)
        errorView.backgroundColor = containerView.backgroundColor
        errorView.onAction = { [weak self] type in
            guard callback == nil else {
                callback?()
                return
            }
            switch type {
            case .empty:
                self?.performEmptyStateAction()
            case .error:
                self?.performErrorStateAction()
            }
        }

        containerView.addSubview(errorView)
        containerView.bringSubviewToFront(errorView)
        strecth(view: errorView)
        updateContainerState()
    }

    func strecth(view: UIView) {
        guard useTopSafeArea else {
            containerView.stretch(view: view)
            return
        }
        let topOffset = (view is BaseLoadingView) ? (sharedLoadingTopOffset ?? 0) : (sharedErrorTopOffset ?? 0)

        let parent: UILayoutGuide
        if #available(iOS 11.0, *) {
            parent = containerView.safeAreaLayoutGuide
        } else {
            parent = containerView.layoutMarginsGuide
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: parent.topAnchor, constant: topOffset),
            view.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
        ])
    }

}

private extension MultiStatesPresentable where Self: UIView {

    func updateContainerState() {
        guard containerView != self else {
            return
        }
        containerView.isUserInteractionEnabled = !containerView.subviews.isEmpty
    }

    func addLoadingView(needAnimating: Bool = true, blocks: [LoadingViewBlock], config: LoadingViewConfig) {
        let loadingView = BaseLoadingView()
        loadingView.configure(blocks: blocks, config: config)
        loadingView.setNeedAnimating(needAnimating)
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        containerView.addSubview(loadingView)
        containerView.stretch(view: loadingView)
        containerView.bringSubviewToFront(loadingView)
    }

}
