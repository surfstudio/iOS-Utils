//
//  UIImage+badgedImage.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public extension UIImage {

    // MARK: - Constants

    private enum Constants {
        static let kern: CGFloat = -0.24
        static let normalFontSize: CGFloat = 10.0
        static let smallFontSize: CGFloat = 9.0
        static let positionMultiplier: CGFloat = 0.75
        static let contextSizeMultiplier: CGFloat = 0.25
    }

    // MARK: - Public Methods

    /// Draws a badge on the image
    /// - Parameter count: count of notificaitons
    /// - Parameter dimension: size of badge
    /// - Parameter strokeWidth: width of transparent line near badge
    /// - Parameter backgroundBadgeColor: color of badge
    func badgedImage(count: Int, dimension: CGFloat, strokeWidth: CGFloat, backgroundBadgeColor: UIColor) -> UIImage? {
        let text = getAttributedString(from: count)

        let textWidth = text.size().width + dimension / 2.0
        let badgeWidth = max(dimension, round(textWidth))

        let x = size.width - dimension / 2.0

        let badgeRect = CGRect(x: x,
                               y: 0.0,
                               width: badgeWidth,
                               height: dimension)

        let imageRect = CGRect(x: 0.0,
                               y: dimension / 4.0,
                               width: size.width,
                               height: size.height)

        let contextSize = CGSize(width: x + badgeWidth,
                                 height: size.height + dimension / 2.0)

        UIGraphicsBeginImageContextWithOptions(contextSize, false, .zero)

        drawBadgeBackground(in: badgeRect, backgroundColor: backgroundBadgeColor)
        text.draw(in: badgeRect)
        drawMaskedStroke(over: badgeRect, in: contextSize, strokeWidth: strokeWidth)
        draw(in: imageRect)

        let resultImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return resultImage?.withRenderingMode(.alwaysOriginal)
    }

    /// Draws a badge on the image in the lower right corner
    /// - Parameter image: picture of badge
    /// - Parameter dimension: size of badge
    func badgedImage(_ badgeImage: UIImage, dimension: CGFloat) -> UIImage? {
        let x = size.width - dimension * Constants.positionMultiplier
        let y = size.height - dimension * Constants.positionMultiplier

        let badgeRect = CGRect(x: x,
                               y: y,
                               width: dimension,
                               height: dimension)

        let imageRect = CGRect(x: 0.0,
                               y: 0,
                               width: size.width,
                               height: size.height)

        let contextSize = CGSize(width: size.width + dimension * Constants.contextSizeMultiplier,
                                 height: size.height + dimension * Constants.contextSizeMultiplier)

        UIGraphicsBeginImageContextWithOptions(contextSize, false, .zero)

        draw(in: imageRect)
        badgeImage.draw(in: badgeRect)

        let resultImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return resultImage?.withRenderingMode(.alwaysOriginal)
    }

}

// MARK: - Private Methods

private extension UIImage {

    /// Converts the number of notifications to a string with the system font and white color
    /// - Parameter count: count of notifications
    func getAttributedString(from count: Int) -> NSAttributedString {
        let count = String(count)

        let baseLineOffset: NSNumber
        let fontSize: CGFloat
        if count.count > 2 {
            fontSize = Constants.smallFontSize
            baseLineOffset = NSNumber(value: -2.0)
        } else {
            fontSize = Constants.normalFontSize
            baseLineOffset = NSNumber(value: -1.0)
        }

        let font = UIFont.systemFont(ofSize: fontSize)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white,
            .baselineOffset: baseLineOffset,
            .paragraphStyle: paragraphStyle,
            .kern: Constants.kern
        ]

        return NSAttributedString(string: count, attributes: attributes)
    }

    /// Draws background of badge
    /// - Parameter rect: size of badge
    /// - Parameter backgroundColor: badge background color
    func drawBadgeBackground(in rect: CGRect, backgroundColor: UIColor) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height / 2.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backgroundColor.cgColor)
        context?.addPath(path.cgPath)
        context?.fillPath()
    }

    /// Draws transparent frame
    /// - Parameters:
    ///   - rect: size of badge
    ///   - size: size of result image
    ///   - strokeWidth: width of transparent line
    func drawMaskedStroke(over rect: CGRect, in size: CGSize, strokeWidth: CGFloat) {
        let rect = CGRect(x: rect.origin.x - strokeWidth,
                          y: rect.origin.y,
                          width: rect.width + strokeWidth,
                          height: rect.height + strokeWidth)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height / 2.0)
        let context = UIGraphicsGetCurrentContext()
        context?.addRect(CGRect(origin: .zero, size: size))
        context?.addPath(path.cgPath)
        context?.clip(using: .evenOdd)
    }

}
