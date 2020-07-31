//
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

/// Protocol for displaying mail error
public protocol MailUtilErrorDisplaying {

    /// Method for displaying mail error
    /// - Parameter error: mail util error
    func display(error: MailUtilError)

}
