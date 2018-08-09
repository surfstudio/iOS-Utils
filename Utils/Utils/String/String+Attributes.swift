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
    /// Text line height
    case lineHeight(CGFloat)
    /// Letter spacing
    case kern(CGFloat)
    /// Text font
    case font(UIFont)
    /// Text foreground (letter) color
    case foregroundColor(UIColor)
    /// Text aligment
    case aligment(NSTextAlignment)

    var attributeKey: NSAttributedStringKey {
        switch self {
        case .lineHeight, .aligment:
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
        case .lineHeight(let value):
            return value
        case .kern(let value):
            return value
        case .font(let value):
            return value
        case .foregroundColor(let value):
            return value
        case .aligment(let value):
            return value
        }
    }
}

public extension String {

    /// Apply attributes to string and returns new attributes string
    func with(attributes: [StringAttribute]) -> NSAttributedString {
        var resultAttributes = [NSAttributedStringKey: Any]()
        let paragraph = NSMutableParagraphStyle()
        for attribute in attributes {
            switch attribute {
            case .lineHeight(let value):
                paragraph.lineSpacing = value
                resultAttributes[attribute.attributeKey] = paragraph
            case .aligment(let value):
                paragraph.alignment = value
                resultAttributes[attribute.attributeKey] = paragraph
            default:
                resultAttributes[attribute.attributeKey] = attribute.value
            }
        }
        return NSAttributedString(string: self, attributes: resultAttributes)
    }
}
