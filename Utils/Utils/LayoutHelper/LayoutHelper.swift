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
            if UIDevice.isSmallPhone {
                constant = isSmallPhone
            }
        }
    }

    @IBInspectable public var isNormal: CGFloat = 0.0 {
        didSet {
            if !UIDevice.isSmallPhone && !UIDevice.isXPhone {
                constant = isNormal
            }
        }
    }

    @IBInspectable public var isXPhone: CGFloat = 0.0 {
        didSet {
            if UIDevice.isXPhone {
                constant = isXPhone
            }
        }
    }

}
