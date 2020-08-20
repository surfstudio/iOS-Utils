//
//  DefaultLoadingModel.swift
//  Utils
//
//  Created by Никита Гагаринов on 18.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit
/// Default model for configuring paddings
public struct DefaultLoadingModel {
    let topOffset: CGFloat
    let bottomOffset: CGFloat

    init(topOffset: CGFloat = 0, bottomOffset: CGFloat = 0) {
        self.topOffset = topOffset
        self.bottomOffset = bottomOffset
    }
}
