//
//  StringAttributesChapter.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 21.06.2022.
//

import SurfPlaybook
import UIKit
import Utils

final class StringAttributesChapter {

    func build() -> PlaybookChapter {
        let chapter = PlaybookChapter(name: "StringAttributes", pages: [])
        chapter
            .add(page: label)
        return chapter
    }

}

// MARK: - Pages

private extension StringAttributesChapter {

    var label: PlaybookPage {
        return PlaybookPage(name: "StringAttributes", description: nil) { () -> UIView in
            let globalSttributes: [StringAttribute] = [
                .font(.systemFont(ofSize: 14)),
                .foregroundColor(.black)
            ]
            let attributedString = StringBuilder(globalAttributes: globalSttributes)
                .add(.string("Title"))
                .add(.delimeterWithString(repeatedDelimeter: .init(type: .space), string: "blue"),
                     with: [.foregroundColor(.blue)])
                .add(.delimeterWithString(repeatedDelimeter: .init(type: .lineBreak), string: "Base style on new line"))
                .add(.delimeterWithString(repeatedDelimeter: .init(type: .space), string: "last word with it's own style"),
                     with: [.font(.boldSystemFont(ofSize: 16)), .foregroundColor(.red)])
                .value
            let label = UILabel()
            label.attributedText = attributedString
            label.numberOfLines = 0
            label.textAlignment = .center
            label.widthAnchor.constraint(equalToConstant: 100).isActive = true
            let container = ViewContainer(label, width: nil, height: nil)
            return container
        }
    }

}
