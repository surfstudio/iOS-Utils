//
//  ViewState.swift
//  Utils
//
//  Created by Никита Гагаринов on 18.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public enum ViewState {
    case error(ViewStateInfo, ViewStateConfiguration)
    case empty(ViewStateInfo, ViewStateConfiguration)
    case loading
    case normal
}
