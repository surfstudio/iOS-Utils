//
//  LayoutHelper.swift
//  Utils
//
//  Created by Vladislav Krupenko on 03/01/2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

public class LayoutHelper: NSLayoutConstraint {

    @IBInspectable public var isSmallPhone: CGFloat = 0.0 {
        didSet {
            guard UIDevice.isSmallPhone else {
                return
            }
            constant = isSmallPhone
        }
    }

    @IBInspectable public var isNormal: CGFloat = 0.0 {
        didSet {
            guard !UIDevice.isSmallPhone && !UIDevice.isXPhone else {
                return
            }
            constant = isNormal
        }
    }

    @IBInspectable public var isXPhone: CGFloat = 0.0 {
        didSet {
            guard UIDevice.isXPhone else {
                return
            }
            constant = isXPhone
        }
    }

    @IBInspectable public var isIPad: CGFloat = 0.0 {
        didSet {
            guard UIDevice.isPad else {
                return
            }
            constant = isIPad
        }
    }

}
