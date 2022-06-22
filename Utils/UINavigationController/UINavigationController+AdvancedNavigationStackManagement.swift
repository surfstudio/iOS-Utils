//
//  UINavigationController+AdvancedNavigationStackManagement.swift
//  Utils
//
//  Created by Александр Чаусов on 02/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

public extension UINavigationController {

    /// Method for calling pushViewController(_, animated) method with completion closure
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        pushViewController(viewController, animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async {
                completion()
            }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in
            completion()
        }
    }

    /// Method for calling popViewController(animated) method with completion closure
    func popViewController(animated: Bool, completion: @escaping () -> Void) {
        popViewController(animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async {
                completion()
            }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in
            completion()
        }
    }

}
