//
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

/// Protocol for supporting routing for UIViewController
public protocol MailUtilRouterHelper {

    /// Method for presenting UIViewController
    /// - Parameter viewController: UIViewController object to present
    func present(_ viewController: UIViewController)

    /// Method for dismissing current UIViewController
    func dismiss()

}
