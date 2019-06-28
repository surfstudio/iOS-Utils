//
//  StringBuilder.swift
//  Utils
//
//  Created by Alexander Filimonov on 28/06/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

public class StringBuilder {

    // MARK: - Nested types

    class StringPart {
        let string: String
        let attributes: [StringAttribute]
        var range: NSRange?

        init(string: String, attributes: [StringAttribute] = []) {
            self.string = string
            self.attributes = attributes
        }
    }

    // MARK: - Readonly properties

    public var value: NSMutableAttributedString {
        return renderAttributedString()
    }

    // MARK: - Private properties

    private var parts: [StringPart] = []
    private var globalAttributes: [StringAttribute] = []

    // MARK: - Initialization

    public init(attributes: [StringAttribute] = []) {
        self.globalAttributes = attributes
    }

    // MARK: - Public methods

    @discardableResult
    public func clear() -> StringBuilder {
        parts = []
        return self
    }

    @discardableResult
    public func add(attributes: [StringAttribute]) -> StringBuilder {
        self.globalAttributes.append(contentsOf: attributes)
        return self
    }

    @discardableResult
    public func add(text: String, with attributes: [StringAttribute] = []) -> StringBuilder {
        parts.append(StringPart(string: text, attributes: attributes))
        return self
    }

    @discardableResult
    public func addSpace() -> StringBuilder {
        parts.append(StringPart(string: " "))
        return self
    }

    @discardableResult
    public func addLineBreak() -> StringBuilder {
        parts.append(StringPart(string: "\n"))
        return self
    }

    // MARK: - Private methods

    private func renderAttributedString() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()

        for part in parts {
            part.range = NSRange(location: attributedString.length, length: part.string.count)
            attributedString.append(NSAttributedString(string: part.string))
        }

        // add global attributes
        attributedString.addAttributes(
            globalAttributes.toDictionary(),
            range: NSRange(location: 0, length: attributedString.length)
        )

        // add local attributes
        for part in parts {
            guard let range = part.range else {
                continue
            }
            attributedString.addAttributes(part.attributes.toDictionary(), range: range)
        }

        return attributedString
    }

}
