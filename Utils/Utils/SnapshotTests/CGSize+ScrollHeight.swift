//
//  CGSize+ScrollHeight.swift
//  SnapshotTests
//

import UIKit

//swiftlint:disable all
extension CGSize {
    /// **ВАЖНО – Не везде работает идеально**
    /// Рассчитывает полный размер экрана с UIScrollView на основе размера экрана из фигмы
    /// Пример: в фигме экран iPhone 8, для iPhone SE увеличится высота и уменьшиться ширина и т.д.
    var snapshotScrollSize: CGSize {
        let topInset = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? .zero
        let bottomInset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? .zero

        if UIScreen.main.bounds.height > (self.height + topInset + bottomInset) {
            return .init(width:  UIScreen.main.bounds.width,
                         height: UIScreen.main.bounds.height)
        } else if UIScreen.main.bounds.width > self.width {
            return .init(width: UIScreen.main.bounds.width,
                         height: self.height + bottomInset)
        } else {
            return .init(width: UIScreen.main.bounds.width,
                         height: self.height + bottomInset + topInset)
        }
    }
}
//swiftlint:enable all
