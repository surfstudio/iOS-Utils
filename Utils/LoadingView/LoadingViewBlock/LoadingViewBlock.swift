//
//  LoadingViewBlock.swift
//  Utils
//
//  Created by Никита Гагаринов on 18.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

public protocol LoadingViewBlock {
    var repeatCount: Int { get }
    func getSubviews() -> [LoadingSubview]
    func configure(color: UIColor)
    func reconfigure(repeatCount: Int) -> Self
}
