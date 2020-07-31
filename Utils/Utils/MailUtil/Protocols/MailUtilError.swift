//
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

/// Error that describes all kinds of mail util errors
public enum MailUtilError: LocalizedError {
    case thereIsNoAbilityToSendMail
    case system(Error)
}
