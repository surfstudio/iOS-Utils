//
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

/// Protocol for getting mail payload
public protocol MailSenderPayloadProvider {

    /// Methods for getting mail payload
    func getPayload() -> MailSenderPayload

}
