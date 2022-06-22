//
//  QueryStringBuilderChapter.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 21.06.2022.
//

import SurfPlaybook
import UIKit
import Utils

final class QueryStringBuilderChapter {

    func build() -> PlaybookChapter {
        let chapter = PlaybookChapter(name: "QueryStringBuilder", pages: [])
        chapter
            .add(page: label)
        return chapter
    }

}

// MARK: - Pages

private extension QueryStringBuilderChapter {

    var label: PlaybookPage {
        return PlaybookPage(name: "QueryStringBuilder", description: nil) { () -> UIView in
            let dict: [String: Any] = ["key1": "value1", "key2": 2.15, "key3": true]
            let queryString = dict.toQueryString()
            let label = UILabel()
            label.text = queryString
            label.numberOfLines = 0
            label.textAlignment = .center
            label.widthAnchor.constraint(equalToConstant: 300).isActive = true
            let container = ViewContainer(label, width: nil, height: nil)
            return container
        }
    }

}

