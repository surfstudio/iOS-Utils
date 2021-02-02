//
//  UIView+SnapshotResize.swift
//  SnapshotTests
//

import UIKit

//swiftlint:disable all
public extension UIView {
    /// Растягивает self-sized view до нужного размера на основе констреинтов
    func snapshotResize() {
        frame = .init(origin: .zero,
                      size: .init(width: UIScreen.main.bounds.width,
                                  height: systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height))
    }
}
//swiftlint:enable all
