//
//  ViewStateInfo.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public struct ViewStateInfo {
    public let title: String
    public let message: String
    public let actionText: String

    public init(title: String = "", message: String = "", actionText: String = "") {
        self.title = title
        self.message = message
        self.actionText = actionText
    }
}
