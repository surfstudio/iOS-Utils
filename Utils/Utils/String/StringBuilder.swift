//
//  StringBuilder.swift
//  Utils
//
//  Created by Alexander Filimonov on 28/06/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

/// Class for building NSAttributedString with different styles for different parts
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

    private enum Constants {
        static let breakSymbol = "\n"
        static let spaceSymbol = " "
    }

    // MARK: - Readonly properties

    public var value: NSMutableAttributedString {
        return renderAttributedString()
    }

    // MARK: - Private properties

    private var parts: [StringPart] = []
    private var globalAttributes: [StringAttribute] = []

    // MARK: - Initialization

    public init(globalAttributes: [StringAttribute] = []) {
        self.globalAttributes = globalAttributes
    }

    // MARK: - Public methods

    @discardableResult
    public func clear() -> StringBuilder {
        parts = []
        return self
    }

    @discardableResult
    public func add(globalAttributes: [StringAttribute]) -> StringBuilder {
        self.globalAttributes.append(contentsOf: globalAttributes)
        return self
    }

    @discardableResult
    public func add(text: String, with attributes: [StringAttribute] = []) -> StringBuilder {
        parts.append(StringPart(string: text, attributes: attributes))
        return self
    }

    @discardableResult
    public func addSpace() -> StringBuilder {
        parts.append(StringPart(string: Constants.spaceSymbol))
        return self
    }

    @discardableResult
    public func addLineBreak() -> StringBuilder {
        parts.append(StringPart(string: Constants.breakSymbol))
        return self
    }

    // MARK: - Private methods

    private func renderAttributedString() -> NSMutableAttributedString {
        // combline attributedString
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
