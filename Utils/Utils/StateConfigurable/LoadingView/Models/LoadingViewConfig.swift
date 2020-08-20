//
//  LoadingViewConfig.swift
//  Utils
//
//  Created by Никита Гагаринов on 18.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

public struct LoadingViewConfig {

    // MARK: - Properties

    /// Top offset for first block
    public let topOffset: CGFloat
    public let placeholderColor: UIColor
    public let shimmerColor: UIColor
    /// If true it will nicely reduce the alpha to the bottom
    public let needGradient: Bool
    /// Will repeat the last block to the end of the screen
    public let needRepeatLast: Bool

    // MARK: - Initialization

    public init(topOffset: CGFloat = 0,
                placeholderColor: UIColor,
                shimmerColor: UIColor = UIColor.white,
                needGradient: Bool = false,
                needRepeatLast: Bool = true) {
        self.topOffset = topOffset
        self.placeholderColor = placeholderColor
        self.shimmerColor = shimmerColor
        self.needGradient = needGradient
        self.needRepeatLast = needRepeatLast
    }

}
