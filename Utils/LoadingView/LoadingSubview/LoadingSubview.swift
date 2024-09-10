//
//  LoadingSubview.swift
//  Utils
//
//  Created by Никита Гагаринов on 18.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

public protocol LoadingSubview: UIView {
    var height: CGFloat { get }

    /// Configuration for placeholders color
    func configure(color: UIColor)
}
