//
//  StringBuilder.swift
//  Utils
//
//  Created by Alexander Filimonov on 28/06/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

final class StringBuilder {

    // MARK: - Properties

    var value: NSMutableAttributedString {
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

    // MARK: - Public methods

    @discardableResult
    public func clear() -> StringBuilder {
        value = NSMutableAttributedString()
        return self
    }

    @discardableResult
    public func add(attributes: [StringAttribute]) -> StringBuilder {
        self.globalAttributes = attributes
        return self
    }

    @discardableResult
    public func add(text: String, with attributed: [StringAttribute]) -> StringBuilder {
        string.append(text.with(attributes: attributed))
        return self
    }

}
