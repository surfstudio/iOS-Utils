//
//  Presentable.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 23.06.2022.
//

import UIKit

/// Describes object that can be presented in view hierarchy
protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {

    func toPresent() -> UIViewController? {
        return self
    }

}
