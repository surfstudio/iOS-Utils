//
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

/// Struct that holds mail properties
public struct MapUtilPayload {

    // MARK: - Public Properties

    public let recipient: String
    public let subject: String?
    public let body: String

    // MARK: - Initializaion

    public init(recipient: String,
                subject: String?,
                body: String) {
        self.recipient = recipient
        self.subject = subject
        self.body = body
    }

}
