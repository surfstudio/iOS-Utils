//
//  Copyright © 2020 Surf. All rights reserved.
//

import MessageUI

/// ViewController to send mail that can be shown inside app
final class InsideAppMailViewController: MFMailComposeViewController {

    // MARK: - Properties

    /// Closure that will be fired after successful of unsuccessful mail sending
    var onClose: ((Error?) -> Void)?

    // MARK: - UIViewController

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mailComposeDelegate = self
    }

}

// MARK: - Methods

extension InsideAppMailViewController {

    /// Method for configuring with payload
    /// - Parameters:
    ///   - recipient: recipient of mail
    ///   - subject: subject of mail
    ///   - body: body of mail
    func setupInitialState(recipient: String, subject: String?, body: String) {
        setToRecipients([recipient])
        setSubject(subject ?? "")
        setMessageBody(body, isHTML: false)
    }

}

// MARK: - MFMailComposeViewControllerDelegate

extension InsideAppMailViewController: MFMailComposeViewControllerDelegate {

    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        onClose?(error)
    }

}
