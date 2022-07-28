//
//  MainRouter.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 23.06.2022.
//

import UIKit

/// Предоставляет методы для обеспечения навигации между экранами
final class MainRouter: Router {

    // MARK: - Private Properties

    private var window: UIWindow? {
        return UIApplication.firstKeyWindow
    }

    private var navigationController: UINavigationController? {
        let keyWindow = UIApplication.firstKeyWindow

        if let tabBar = keyWindow?.rootViewController as? UITabBarController {
            return tabBar.selectedViewController as? UINavigationController
        }

        return keyWindow?.rootViewController as? UINavigationController
    }

    private var tabBarController: UITabBarController? {
        let keyWindow = UIApplication.firstKeyWindow
        return keyWindow?.rootViewController as? UITabBarController
    }

    private var topNavigationController: UINavigationController? {
        return topViewController?.navigationController
    }

    private var topViewController: UIViewController? {
        return UIApplication.topViewController()
    }

    // MARK: - Router

    func present(_ module: Presentable?) {
        self.present(module, animated: true, completion: nil)
    }

    func present(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        guard let controller = module?.toPresent() else {
            return
        }

        self.topViewController?.present(controller, animated: animated, completion: completion)
    }

    func push(_ module: Presentable?) {
        self.push(module, animated: true)
    }

    func push(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else {
            return
        }
        topNavigationController?.pushViewController(controller, animated: animated)
    }

    func popModule() {
        self.popModule(animated: true)
    }

    func popModule(animated: Bool) {
        topNavigationController?.popViewController(animated: animated)
    }

    func popPreviousView() {
        guard
            var controllers = topNavigationController?.viewControllers,
            controllers.count >= 3 else {
                return
        }
        controllers.remove(at: controllers.count - 2)
        topNavigationController?.viewControllers = controllers
    }

    func popToRoot(animated: Bool) {
        topNavigationController?.popToRootViewController(animated: animated)
    }

    func dismissModule() {
        self.dismissModule(animated: true, completion: nil)
    }

    func dismissModule(from module: Presentable?) {
        module?.toPresent()?.dismiss(animated: true, completion: nil)
    }

    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        topViewController?.dismiss(animated: animated, completion: completion)
    }

    func dismissAll(animated: Bool, completion: (() -> Void)?) {
        guard tabBarController?.presentedViewController != nil else {
            completion?()
            return
        }
        tabBarController?.dismiss(animated: animated, completion: completion)
    }

    func setNavigationControllerRootModule(_ module: Presentable?, animated: Bool = false, hideBar: Bool = false) {
        guard let controller = module?.toPresent() else {
            return
        }
        navigationController?.isNavigationBarHidden = hideBar
        navigationController?.setViewControllers([controller], animated: false)
    }

    func setRootModule(_ module: Presentable?) {
        window?.rootViewController = module?.toPresent()
    }

    func setTab(_ index: Int) {
        tabBarController?.selectedIndex = index
    }

}
