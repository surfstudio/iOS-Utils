//
//  StateConfigurable.swift
//  Utils
//
//  Created by Никита Гагаринов on 18.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public protocol StateConfigurable {
    func set(state: ViewState)
}

public extension StateConfigurable where Self: MultiStatesPresentable {

    func set(state: ViewState) {
        switch state {
        case .empty(let model):
            hideErrorView()
            hideLoaderView()
            showEmptyView(info: model, nil)
        case .error(let model):
            hideEmptyView()
            hideLoaderView()
            showErrorView(info: model, nil)
        case .loading:
            hideEmptyView()
            hideErrorView()
            showLoaderView()
        case .normal:
            hideEmptyView()
            hideErrorView()
            hideLoaderView()
        }
    }

}
