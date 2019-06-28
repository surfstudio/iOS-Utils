//
//  StringBuilder.swift
//  Utils
//
//  Created by Alexander Filimonov on 28/06/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

public class StringBuilder {

    // MARK: - Properties

    public var value: NSMutableAttributedString {
        get {
            let attributedString = string
            attributedString.addAttributes(
                globalAttributes.toDictionary(),
                range: NSRange(location: 0, length: attributedString.length)
            )
            return attributedString
        }
        set {
            string = newValue
        }
    }

    // MARK: - Private properties

    private var string = NSMutableAttributedString()
    private var globalAttributes: [StringAttribute] = []

    // MARK: - Initialization

    public init(attributes: [StringAttribute] = []) {
        self.globalAttributes = attributes
    }

    // MARK: - Public methods

    @discardableResult
    public func clear() -> StringBuilder {
        value = NSMutableAttributedString()
        return self
    }

    @discardableResult
    public func add(attributes: [StringAttribute]) -> StringBuilder {
        self.globalAttributes.append(contentsOf: attributes)
        return self
    }

    @discardableResult
    public func add(text: String, with attributes: [StringAttribute] = []) -> StringBuilder {
        string.append(text.with(attributes: attributes))
        return self
    }

}
