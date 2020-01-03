//
//  UIStyle.swift
//  Utils
//
//  Created by Vladislav Krupenko on 03/01/2020.
//  Copyright © 2020 Surf. All rights reserved.
//

public protocol UIStyleProtocol {
    associatedtype Control: UIView
    func apply(for: Control)
}

open class UIStyle<Control: UIView>: UIStyleProtocol {
    public init() {}
    open func apply(for: Control) {}
}

public protocol AttributableStyle {
    func attributes() -> [NSAttributedString.Key: Any]
}
