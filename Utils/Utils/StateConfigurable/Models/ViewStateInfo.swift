//
//  ViewStateInfo.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public struct ViewStateInfo {
    let title: String
    let message: String
    let action: String

    init(title: String = "", message: String = "", action: String = "") {
        self.title = title
        self.message = message
        self.action = action
    }
}
