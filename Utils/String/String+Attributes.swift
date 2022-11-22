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
    /// Text line spacing (paragraphStyle.lineSpacing)
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
    /// Text base line offset (vertical)
    case baselineOffset(CGFloat)
    /// Text line height, in points.
    ///
    /// If you also specify `.font` value, then will be used `paragraph.lineHeightMultiple`,
    /// otherwise - `paragraph.minimumLineHeight` and `paragraph.maximumLineHeight`
    case lineHeight(CGFloat)
    /// Paragrapth spacing
    case paragraphSpacing(CGFloat)

    /// Previous version of .lineHeight attribute
    ///
    /// It needs for backward compatibility.
    /// It setups paragraphStyle.lineSpacing value, but gets as parameter not spacing value,
    /// but total lineHeight value. And setup paragraphStyle.lineSpacing as
    /// `lineHeight - font.lineHeight`.
    /// So you need to specify in attributes array both `oldLineHeight` and `.font`, otherwise -
    /// nothing will happen.
    case oldLineHeight(CGFloat)
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

        init?(with style: NSUnderlineStyle) {
            switch style {
            case .double:
                self = .double
            case .single:
                self = .single
            default:
                return nil
            }
        }
    }
}

// MARK: - StringAttribute extension

extension StringAttribute {
    var attributeKey: NSAttributedString.Key {
        switch self {
        case .lineSpacing, .aligment, .lineBreakMode, .paragraphSpacing:
            return NSAttributedString.Key.paragraphStyle
        case .lineHeight, .oldLineHeight:
            return NSAttributedString.Key.paragraphStyle
        case .kern:
            return NSAttributedString.Key.kern
        case .font:
            return NSAttributedString.Key.font
        case .foregroundColor:
            return NSAttributedString.Key.foregroundColor
        case .crossOut:
            return NSAttributedString.Key.strikethroughStyle
        case .baselineOffset:
            return NSAttributedString.Key.baselineOffset
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
        case .lineHeight(let value):
            return value
        case .crossOut(let style):
            return style.coreValue.rawValue
        case .lineBreakMode(let value):
            return value
        case .baselineOffset(let value):
            return value
        case .paragraphSpacing(let value):
            return value
        case .oldLineHeight(let value):
            return value
        }
    }
}

// MARK: - Public static methods

public extension StringAttribute {

    // init from attributs array
    static func from(dictionary: [NSAttributedString.Key: Any]) -> [StringAttribute] {
        var stringAttributedArray = [StringAttribute]()

        if let baselineOffset = dictionary[.baselineOffset] as? CGFloat {
            stringAttributedArray.append(.baselineOffset(baselineOffset))
        }

        if let strikethroughStyle = dictionary[.strikethroughStyle] as? NSUnderlineStyle,
           let crossOutStyle = CrossOutStyle(with: strikethroughStyle) {
            stringAttributedArray.append(.crossOut(style: crossOutStyle))
        }

        if let foregroundColor = dictionary[.foregroundColor] as? UIColor {
            stringAttributedArray.append(.foregroundColor(foregroundColor))
        }

        if let font = dictionary[.font] as? UIFont {
            stringAttributedArray.append(.font(font))
        }

        if let kernValue = dictionary[.kern] as? CGFloat {
            stringAttributedArray.append(.kern(kernValue))
        }

        if let value = dictionary[.paragraphStyle],
           let mutableParagraphStyle = value as? NSMutableParagraphStyle {
            stringAttributedArray.append(.aligment(mutableParagraphStyle.alignment))
            stringAttributedArray.append(.lineBreakMode(mutableParagraphStyle.lineBreakMode))
            stringAttributedArray.append(.lineHeight(mutableParagraphStyle.minimumLineHeight))
            stringAttributedArray.append(.lineSpacing(mutableParagraphStyle.lineSpacing))
            stringAttributedArray.append(.paragraphSpacing(mutableParagraphStyle.paragraphSpacing))
        }

        return stringAttributedArray
    }
}

// MARK: - String extension

public extension String {
    /// Apply attributes to string and returns new attributes string
    func with(attributes: [StringAttribute]) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes.toDictionary())
    }
}

// MARK: - Array extension

public extension Array where Element == StringAttribute {
    func toDictionary() -> [NSAttributedString.Key: Any] {
        var resultAttributes = [NSAttributedString.Key: Any]()
        let paragraph = NSMutableParagraphStyle()
        for attribute in self {
            switch attribute {
            case .lineHeight(let lineHeight):
                if let font = self.findFont() {
                    paragraph.lineHeightMultiple = lineHeight / font.lineHeight
                } else {
                    paragraph.minimumLineHeight = lineHeight
                    paragraph.maximumLineHeight = lineHeight
                }
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
            case .paragraphSpacing(let value):
                paragraph.paragraphSpacing = value
                resultAttributes[attribute.attributeKey] = paragraph
            case .oldLineHeight(let value):
                guard let font = self.findFont() else {
                    break
                }
                paragraph.lineSpacing = value - font.lineHeight
                resultAttributes[attribute.attributeKey] = paragraph
            default:
                resultAttributes[attribute.attributeKey] = attribute.value
            }
        }
        return resultAttributes
    }

    // MARK: - Private Methods

    /// Returns font from array of StringAttributes, if it exists, and nil otherwise
    private func findFont() -> UIFont? {
        for value in self {
            if case .font(let font) = value {
                return font
            }
        }
        return nil
    }
}
