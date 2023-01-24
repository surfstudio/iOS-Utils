//
//  ViewAccessibilityProtocol.swift
//  Unicredit
//
//  Created by Егор Егоров on 12/02/2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

public protocol ViewAccessibilityProtocol {

    func setAccessibilityIdentifier(_ identifier: String, for item: UIAccessibilityIdentification)

}

public extension ViewAccessibilityProtocol {

    func setAccessibilityIdentifier(_ identifier: String, for item: UIAccessibilityIdentification) {
        item.accessibilityIdentifier = identifier
    }

}
