//
//  ActionableLabelDefaultParameters.swift
//  Unicredit
//
//  Created by Егор Егоров on 12/02/2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

public protocol ActionableLabelParameters {
    var highlightedAlpha: CGFloat { get }
    var localizableKey: String { get }
    var defaultAttributes: [StringAttribute] { get }
}

public extension ActionableLabelParameters {

    var highlightedAlpha: CGFloat {
        return 0.5
    }

    var localizableKey: String {
        return "actionableLabel"
    }

    var defaultAttributes: [StringAttribute] {
        return [
            .font(.systemFont(ofSize: 14)),
            .aligment(.left),
            .lineSpacing(.zero),
            .foregroundColor(.black)
        ]
    }

}
