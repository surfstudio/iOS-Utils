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

    // MARK: - Constants

    private enum Constants {
        static let breakSymbol = "\n"
        static let spaceSymbol = " "
    }

    // MARK: - Public nested types

    public enum TextDelimeterType {
        case lineBreak
        case space

        var string: String {
            switch self {
            case .lineBreak:
                return Constants.breakSymbol
            case .space:
                return Constants.spaceSymbol
            }
        }
    }

    /// Struct for describing delimeter and it's parameters
    public struct TextDelimeter {
        let type: TextDelimeterType
        let count: Int

        var string: String? {
            // swiftlint:disable empty_count
            guard count > 0 else {
                return nil
            }
            return String(repeating: type.string, count: count)
        }

        init(type: TextDelimeterType, count: Int = 1) {
            self.type = type
            self.count = count
        }
    }

    /// Enum for describing different types of text blocks in rendered attributed string
    public enum TextBlock {
        case string(String?)
        case delimeterWithString(delimeter: TextDelimeter, string: String?)
        case delimeter(delimeter: TextDelimeter)

        var string: String? {
            switch self {
            case .string(let string):
                return string
            case .delimeterWithString(let delimeter, let string):
                let parts = [delimeter.string, string].compactMap { $0 }
                guard !parts.isEmpty else {
                    return nil
                }
                return parts.joined()
            case .delimeter(let delimeter):
                return delimeter.string
            }
        }
    }

    // MARK: - Internal nested types

    /// Part of string to render in attributed string
    class StringPart {
        let block: TextBlock
        let attributes: [StringAttribute]

        init(block: TextBlock, attributes: [StringAttribute] = []) {
            self.block = block
            self.attributes = attributes
        }
    }

    class StringPartNormalized {
        let string: String
        let attributes: [NSAttributedString.Key: Any]
        var range: NSRange?

        init?(from stringPart: StringPart) {
            guard let string = stringPart.block.string else {
                return nil
            }
            self.string = string
            self.attributes = stringPart.attributes.toDictionary()
        }
    }

    // MARK: - Readonly properties

    /// Rendered NSMutableAttributedString (render after each calling)
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

    /// Methd for clearing string parts
    @discardableResult
    public func clear() -> StringBuilder {
        parts = []
        return self
    }

    /// Method for adding global attributes to whole string
    /// - Parameter globalAttributes: attributes to apply
    @discardableResult
    public func add(globalAttributes: [StringAttribute]) -> StringBuilder {
        self.globalAttributes.append(contentsOf: globalAttributes)
        return self
    }

    /// Method for adding text block to attributed
    /// - Parameters:
    ///   - block: block to add
    ///   - attributes: attributes to apply
    @discardableResult
    public func add(_ block: TextBlock, with attributes: [StringAttribute] = []) -> StringBuilder {
        parts.append(StringPart(block: block, attributes: attributes))
        return self
    }

    // MARK: - Deprecated Public Methods

    /// Method for adding string part
    /// - Parameters:
    ///   - text: string to add
    ///   - attributes: attributes to apply to adding string
    @available(*, deprecated, message: "Use `add(.string(\"Your text\"), with:)` instead")
    @discardableResult
    public func add(text: String, with attributes: [StringAttribute] = []) -> StringBuilder {
        parts.append(StringPart(block: .string(text), attributes: attributes))
        return self
    }

    /// Method for adding space to string
    /// (previous part's attributes will be applied to avoid bugs)
    /// - Parameter count: count of space repeatings
    @available(*, deprecated, message: "Use `add(.delimeter(.init(type: .space, count: 2)), with:)` instead")
    @discardableResult
    public func addSpace(count: Int = 1) -> StringBuilder {
        let attributes = parts.last?.attributes ?? []
        parts.append(StringPart(block: .delimeter(delimeter: .init(type: .space, count: count)),
                                attributes: attributes))
        return self
    }

    /// Method for adding line breaks to string
    /// (previous part's attributes will be applied to avoid bugs)
    /// - Parameter count: count of line breaks repeatings
    @available(*, deprecated, message: "Use `add(.delimeter(.init(type: .lineBreak, count: 2)), with:)` instead")
    @discardableResult
    public func addLineBreak(count: Int = 1) -> StringBuilder {
        let attributes = parts.last?.attributes ?? []
        parts.append(StringPart(block: .delimeter(delimeter: .init(type: .lineBreak, count: count)),
                                attributes: attributes))
        return self
    }

    // MARK: - Private methods

    private func renderAttributedString() -> NSMutableAttributedString {
        // combline attributedString
        let attributedString = NSMutableAttributedString()
        let normalizedParts = parts.compactMap { StringPartNormalized(from: $0) }
        for part in normalizedParts {
            part.range = NSRange(location: attributedString.length, length: part.string.count)
            attributedString.append(NSAttributedString(string: part.string))
        }

        // add global attributes
        attributedString.addAttributes(
            globalAttributes.toDictionary(),
            range: NSRange(location: 0, length: attributedString.length)
        )

        // add local attributes
        for part in normalizedParts {
            guard let range = part.range else {
                continue
            }
            attributedString.addAttributes(part.attributes, range: range)
        }

        return attributedString
    }

}
