//
//  UIImageExtensions.swift
//  Utils
//
//  Created by Vladislav Krupenko on 03/11/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

public extension UIImage {

    // MARK: - Constants

    private enum Constants {
        static let kern: CGFloat = -0.24
    }

    /// Init method for creating UIImage of a given color
    /// - Parameters:
    ///     - color: Optional value, by default clear color
    ///     - size: Optional value, by default size 1*1
    convenience init?(color: UIColor?, size: CGSize = CGSize(width: 1, height: 1)) {
        let color = color ?? UIColor.clear
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }

    /// Method returns UIImage with given tint color
    func mask(with color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        defer { UIGraphicsEndImageContext() }

        guard let context = UIGraphicsGetCurrentContext() else {
            return self
        }
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)

        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        guard let mask = self.cgImage else {
            return self
        }
        context.clip(to: rect, mask: mask)

        color.setFill()
        context.fill(rect)

        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return self
        }
        return newImage
    }

    /// Method return UIImage with given alpha
    func mask(with alpha: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }

    /// Draws initials
    func drawInitials(firstname: String,
                      lastname: String,
                      font: UIFont,
                      textColor: UIColor) -> UIImage? {

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle,
            .kern: Constants.kern
        ]
        let string = String(firstname.prefix(1) + lastname.prefix(1))
        let initials = NSAttributedString(string: string,
                                          attributes: attributes)
        let x = size.width / 2.0 - initials.size().width / 2.0
        let y = size.height / 2.0 - initials.size().height / 2.0
        let textRect = CGRect(origin: CGPoint(x: x, y: y), size: initials.size())
        UIGraphicsBeginImageContextWithOptions(size, false, .zero)
        draw(in: CGRect(origin: .zero, size: size))
        initials.draw(in: textRect)

        let resultImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return resultImage
    }

}
