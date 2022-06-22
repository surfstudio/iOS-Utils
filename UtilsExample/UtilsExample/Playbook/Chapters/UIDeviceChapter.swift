//
//  UIDeviceChapter.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 21.06.2022.
//

import SurfPlaybook
import UIKit
import Utils

final class UIDeviceChapter {

    func build() -> PlaybookChapter {
        let chapter = PlaybookChapter(name: "UIDevice", pages: [])
        chapter
            .add(page: label)
        return chapter
    }

}

// MARK: - Pages

private extension UIDeviceChapter {

    var label: PlaybookPage {
        return PlaybookPage(name: "UIDevice", description: nil) { () -> UIView in
            
            let label = UILabel()
            label.text = "SmallPhone: \(UIDevice.isSmallPhone),\n NormalPhone: \(UIDevice.isNormalPhone),\n XPhone: \(UIDevice.isXPhone),\n Pad: \(UIDevice.isPad)"
            label.numberOfLines = 0
            label.textAlignment = .center
            label.widthAnchor.constraint(equalToConstant: 200).isActive = true
            let container = ViewContainer(label, width: nil, height: nil)
            return container
        }
    }

}

