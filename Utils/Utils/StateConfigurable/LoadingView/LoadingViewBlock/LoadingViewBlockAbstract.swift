//
//  LoadingViewBlockAbstract.swift
//  Utils
//
//  Created by Никита Гагаринов on 18.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

public protocol LoadingViewBlockAbstract {
    var repeatCount: Int { get }
    func getSubviews() -> [LoadingSubviewAbstract]
    func configure(color: UIColor)
    func reconfigure(repeatCount: Int) -> Self
}
