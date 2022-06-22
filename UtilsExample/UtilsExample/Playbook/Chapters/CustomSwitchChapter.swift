//
//  SkeletonViewChapter.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 21.06.2022.
//

import SurfPlaybook
import UIKit
import Utils

final class CustomSwitchChapter {

    func build() -> PlaybookChapter {
        let chapter = PlaybookChapter(name: "CustomSwitchControl", pages: [])
        chapter
            .add(page: label)
        return chapter
    }

}

// MARK: - Pages

private extension CustomSwitchChapter {

    var label: PlaybookPage {
        return PlaybookPage(name: "CustomSwitchControl", description: nil) { () -> UIView in
            let customSwitch = CustomSwitch(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            customSwitch.layoutConfiguration = .init(padding: 1, spacing: 3, cornerRatio: 0.5)
            customSwitch.colorsConfiguration = .init(offColorConfiguraion: CSSimpleColorConfiguration(color: .white),
                                                     onColorConfiguraion: CSSimpleColorConfiguration(color: .green),
                                                     thumbColorConfiguraion: CSGradientColorConfiguration(colors: [.lightGray, .yellow],
                                                                                                          locations: [0, 1]))
            customSwitch.thumbConfiguration = .init(cornerRatio: 0.5, shadowConfiguration: .init(color: .black, offset: CGSize(), radius: 5, oppacity: 0.1))
            customSwitch.animationsConfiguration = .init(duration: 0.1, usingSpringWithDamping: 0.7)

            customSwitch.setOn(true, animated: false)

            let container = ViewContainer(customSwitch, width: 100, height: 50)
            return container
        }
    }

}
