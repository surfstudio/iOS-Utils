//
//  AnyStyle.swift
//  Utils
//
//  Created by Vladislav Krupenko on 03/01/2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

public struct AnyStyle<Control: UIView>: UIStyleProtocol {

    // MARK: - Public Properties

    public let box: BaseBox<Control>

    // MARK: - Initialization

    public init<T>(style: T) where T: UIStyleProtocol, T.Control == Control {
        self.box = StyleBox(style: style)
    }

    // MARK: - Public Methods

    public func apply(for control: Control) {
        self.box.apply(for: control)
    }

}

public class BaseBox<Control: UIView>: UIStyleProtocol {

    // MARK: - Initialization

    public init() {}

    // MARK: - Public Methods

    public func apply(for control: Control) {
        fatalError("You can't use \(self.self)")
    }

}

public class StyleBox<Style: UIStyleProtocol>: BaseBox<Style.Control> {

    // MARK: - Public Properties

    let style: Style

    // MARK: - Initialization

    public init(style: Style) {
        self.style = style
        super.init()
    }

    // MARK: - BaseBox

    override public func apply(for control: Control) {
        self.style.apply(for: control)
    }

}
