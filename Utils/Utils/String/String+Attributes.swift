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

    /// Figma friendly case means that lineSpacing = lineHeight - font.lineHeight
    /// This case provide possibility to set both `font` and `lineSpacing`
    /// First parameter is Font and second parameter is lineHeight property from Figma
    /// For more details see [#14](https://github.com/surfstudio/iOS-Utils/issues/14)
    case lineHeight(CGFloat, font: UIFont)

    var attributeKey: NSAttributedStringKey {
        switch self {
        case .lineSpacing, .aligment, .lineHeight:
            return NSAttributedStringKey.paragraphStyle
        case .kern:
            return NSAttributedStringKey.kern
        case .font:
            return NSAttributedStringKey.font
        case .foregroundColor:
            return NSAttributedStringKey.foregroundColor
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
        }
    }
}

public extension String {

    /// Apply attributes to string and returns new attributes string
    func with(attributes: [StringAttribute]) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes.toDictionary())
    }
}

private extension Array where Element == StringAttribute {
    func normalizedAttributes() -> [StringAttribute] {
        var result = [StringAttribute](self)

        self.forEach { item in
            switch item {
            case .lineHeight(_, let font):
                result.append(.font(font))
            default: break
            }
        }

        return result
    }
}

public extension Array where Element == StringAttribute {
    func toDictionary() -> [NSAttributedStringKey: Any] {
        var resultAttributes = [NSAttributedStringKey: Any]()
        let paragraph = NSMutableParagraphStyle()
        for attribute in self.normalizedAttributes() {
            switch attribute {
            case .lineHeight(let lineHeight, let font):
                paragraph.lineSpacing = lineHeight - font.lineHeight
                resultAttributes[attribute.attributeKey] = paragraph
            case .lineSpacing(let value):
                paragraph.lineSpacing = value
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
