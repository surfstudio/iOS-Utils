//
//  String+Attributes.swift
//  Utils
//
//  Created by Alexander Kravchenkov on 09.08.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

import Foundation
import UIKit

/// Attributes for string.
public enum StringAttribute {
    /// Text line spacing
    case lineSpacing(CGFloat)
    /// Letter spacing
    case kern(CGFloat)
    /// Text font
    case font(UIFont)
    /// Text foreground (letter) color
    case foregroundColor(UIColor)
    /// Text aligment
    case aligment(NSTextAlignment)
    /// Text crossing out
    case crossOut(style: CrossOutStyle)
    /// Text line break mode
    case lineBreakMode(NSLineBreakMode)

    /// Figma friendly case means that lineSpacing = lineHeight - font.lineHeight
    /// This case provide possibility to set both `font` and `lineSpacing`
    /// First parameter is Font and second parameter is lineHeight property from Figma
    /// For more details see [#14](https://github.com/surfstudio/iOS-Utils/issues/14)
    case lineHeight(CGFloat, font: UIFont)
}

// MARK: - Nested types

extension StringAttribute {
    /// Enum for configuring style of crossOut text
    public enum CrossOutStyle {
        case single
        case double

        var coreValue: NSUnderlineStyle {
            switch self {
            case .double:
                return NSUnderlineStyle.double
            case .single:
                return NSUnderlineStyle.single
            }
        }
    }
}

// MARK: - StringAttribute extension

extension StringAttribute {
    var attributeKey: NSAttributedString.Key {
        switch self {
        case .lineSpacing, .aligment, .lineHeight, .lineBreakMode:
            return NSAttributedString.Key.paragraphStyle
        case .kern:
            return NSAttributedString.Key.kern
        case .font:
            return NSAttributedString.Key.font
        case .foregroundColor:
            return NSAttributedString.Key.foregroundColor
        case .crossOut:
            return NSAttributedString.Key.strikethroughStyle
        }
    }

    fileprivate var value: Any {
        switch self {
        case .lineSpacing(let value):
            return value
        case .kern(let value):
            return value
        case .font(let value):
            return value
        case .foregroundColor(let value):
            return value
        case .aligment(let value):
            return value
        case .lineHeight(let lineHeight, let font):
            return lineHeight - font.lineHeight
        case .crossOut(let style):
            return style.coreValue.rawValue
        case .lineBreakMode(let value):
            return value
        }
    }
}

// MARK: - String extension

public extension String {
    /// Apply attributes to string and returns new attributes string
    func with(attributes: [StringAttribute]) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes.toDictionary())
    }
}

// MARK: - Private array extension

private extension Array where Element == StringAttribute {
    func normalizedAttributes() -> [StringAttribute] {
        var result = [StringAttribute](self)

        self.forEach { item in
            switch item {
            case .lineHeight(_, let font):
                result.append(.font(font))
            default:
                break
            }
        }

        return result
    }
}

// MARK: - Public array extension

public extension Array where Element == StringAttribute {
    func toDictionary() -> [NSAttributedString.Key: Any] {
        var resultAttributes = [NSAttributedString.Key: Any]()
        let paragraph = NSMutableParagraphStyle()
        for attribute in self.normalizedAttributes() {
            switch attribute {
            case .lineHeight(let lineHeight, let font):
                paragraph.lineSpacing = lineHeight - font.lineHeight
                resultAttributes[attribute.attributeKey] = paragraph
            case .lineSpacing(let value):
                paragraph.lineSpacing = value
                resultAttributes[attribute.attributeKey] = paragraph
            case .lineBreakMode(let value):
                paragraph.lineBreakMode = value
                resultAttributes[attribute.attributeKey] = paragraph
            case .aligment(let value):
                paragraph.alignment = value
                resultAttributes[attribute.attributeKey] = paragraph
            default:
                resultAttributes[attribute.attributeKey] = attribute.value
            }
        }
        return resultAttributes
    }
}
