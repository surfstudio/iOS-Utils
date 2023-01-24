//
//  StringAttribute+Array.swift
//  Utils
//
//  Created by Konstantin Porokhov on 24.01.2023.
//  Copyright © 2023 Surf. All rights reserved.
//

import UIKit

public extension Array where Element == StringAttribute {
    var foregroundColor: UIColor? {
        for attribute in self {
            if case .foregroundColor(let foregroundColor) = attribute {
                return foregroundColor
            }
        }
        return nil
    }
}
