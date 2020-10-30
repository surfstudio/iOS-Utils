//
//  File.swift
//  Utils
//
//  Created by Никита Гагаринов on 30.10.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public struct ViewStateConfiguration {
    public let actionStyle: UIStyle<UIButton>
    public let messageStyle: UIStyle<UILabel>
    public let iconWidth: CGFloat
    public let messageTopOffset: CGFloat
    public let icon: UIImage

    public init(actionStyle: UIStyle<UIButton>,
                messageStyle: UIStyle<UILabel>,
                iconWidth: CGFloat,
                messageTopOffset: CGFloat,
                icon: UIImage) {
        self.actionStyle = actionStyle
        self.messageStyle = messageStyle
        self.iconWidth = iconWidth
        self.messageTopOffset = messageTopOffset
        self.icon = icon
    }

}
