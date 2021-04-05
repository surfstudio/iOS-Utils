//
//  UIViewController+SnapshotContainers.swift
//  SnapshotTests
//

import UIKit

//swiftlint:disable all
public extension UIViewController {
    /// Оборачивает контроллер в таббар с навбаром
    /// - Parameters:
    ///   - tabBarController: тип кастомного таббара
    ///   - navigationController: тип кастомного навбара
    ///   - tabBarItems: все айтемы используемые в приложении
    ///   - selected: выбранный айтем
    /// - Returns: контроллер, обернутый в таббарконтроллер
    func embedded<T: UITabBarController, N: UINavigationController, I: UITabBarItem>(
        in tabBarController: T.Type,
        navigationController: N.Type,
        tabBarItems: [I],
        selected: Int) -> T {

        let tabBarViewController = T()
        let controllers = tabBarItems.compactMap { item -> UINavigationController? in
            let navigationController = N()
            navigationController.tabBarItem = item
            return navigationController
        }

        tabBarViewController.viewControllers = controllers
        controllers[selected].setViewControllers([self], animated: false)
        tabBarViewController.selectedViewController = controllers[selected]

        return tabBarViewController
    }

    /// Оборачивает контроллер в навбар
    /// - Parameter navigationController: тип кастомного навбара
    /// - Returns: контроллер, обернутый в навбарконтроллер
    func pushed<N: UINavigationController>(in navigationController: N.Type) -> N {
        let viewController = UIViewController()
        let navigationController = N(rootViewController: viewController)
        navigationController.delegate?.navigationController?(navigationController, willShow: self, animated: false)
        navigationController.pushViewController(self, animated: false)
        return navigationController
    }
}
//swiftlint:enable all
