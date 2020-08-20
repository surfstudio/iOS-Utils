//
//  ErrorViewConfigurable.swift
//  Utils
//
//  Created by Никита Гагаринов on 18.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

// Protocol for ErrorView configuration, you should extend ErrorViewState
// with this protocol or write your own implementation
public protocol ErrorViewConfigurable {
    var actionStyle: UIStyle<UIButton> { get }
    var messageStyle: UIStyle<UILabel> { get }
    var iconWidth: CGFloat { get }
    var messageTopOffset: CGFloat { get }
    var icon: UIImage { get }
}
