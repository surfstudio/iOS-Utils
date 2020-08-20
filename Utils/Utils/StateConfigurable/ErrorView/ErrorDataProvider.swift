//
//  ErrorDataProvider.swift
//  Utils
//
//  Created by Никита Гагаринов on 19.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public protocol ErrorDataProvider {
    var errorView: ErrorViewAbsract { get }
}
