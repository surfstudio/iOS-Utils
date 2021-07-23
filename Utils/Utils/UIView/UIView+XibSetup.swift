//
//  UIView+XibSetup.swift
//  Utils
//
//  Created by Anton Dryakhlykh on 15.10.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

public extension UIView {
    func xibSetup(bundle: Bundle) {
        let view = loadFromNib(bundle: bundle)
        addSubview(view)
        stretch(view: view)
    }

    func loadFromNib<T: UIView>(bundle: Bundle) -> T {
        let selfType = type(of: self)
        let nibName = String(describing: selfType)
        let nib = UINib(nibName: nibName, bundle: bundle)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            return T()
        }

        return view
    }

    static func loadFromNib<T: UIView>(bundle: Bundle) -> T {
        let nibName = String(describing: self)
        let nib = UINib(nibName: nibName, bundle: bundle)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            return T()
        }

        return view
    }

    func xibSetup() {
        let view = loadFromNib()
        addSubview(view)
        stretch(view: view)
    }

    func loadFromNib<T: UIView>() -> T {
        #if SWIFT_PACKAGE
        let bundle = Bundle.module
        #else
        let bundle = Bundle(for: type(of: self))
        #endif
        return loadFromNib(bundle: bundle)
    }

    static func loadFromNib<T: UIView>() -> T {
        #if SWIFT_PACKAGE
        let bundle = Bundle.module
        #else
        let bundle = Bundle(for: self)
        #endif
        return loadFromNib(bundle: bundle)
    }

    func stretch(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
