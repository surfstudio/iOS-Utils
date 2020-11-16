//
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

/// Mail util that helps to send mail
/// (such utility can send mail inside app, via defaul mail app
/// or show error if there are no available abilities to send)
public final class MailUtil {

    // MARK: - Nested Types

    private enum MailSendType {
        case insideApp
        case defaultAppMail
    }

    // MARK: - Private Properties

    private let errorDisplaying: MailSenderErrorDisplaying
    private let payloadProvider: MailSenderPayloadProvider
    private let routerHelper: MailSenderRouterHelper

    // MARK: - Initializaion

    public init(errorDisplaying: MailSenderErrorDisplaying,
                payloadProvider: MailSenderPayloadProvider,
                routerHelper: MailSenderRouterHelper) {
        self.errorDisplaying = errorDisplaying
        self.payloadProvider = payloadProvider
        self.routerHelper = routerHelper
    }

    // MARK: - Public Methods

    /// Method for understannding if user can send mail
    public func canSend() -> Bool {
        return getMailSendType() != nil
    }

    /// Method for sending mail
    public func send() {
        let payload = payloadProvider.getPayload()
        switch getMailSendType() {
        case .insideApp:
            openInsideApp(payload: payload)
        case .defaultAppMail:
            openDefaultAppMail(payload: payload)
        case .none:
            errorDisplaying.display(error: .thereIsNoAbilityToSendMail)
        }
    }

    // MARK: - Private Methods

    private func getMailSendType() -> MailSendType? {
        if canSendInsideApp() {
            return .insideApp
        }
        if canSendInDefaultAppMail() {
            return .defaultAppMail
        }
        return nil
    }

    private func canSendInsideApp() -> Bool {
        return InsideAppMailViewController.canSendMail()
    }

    private func openInsideApp(payload: MailSenderPayload) {
        let viewController = InsideAppMailViewController()
        viewController.setupInitialState(recipient: payload.recipient,
                                         subject: payload.subject,
                                         body: payload.body)
        viewController.onClose = { optionalError in
            guard let error = optionalError else {
                self.routerHelper.dismiss()
                return
            }
            self.errorDisplaying.display(error: .system(error))
        }
        routerHelper.present(viewController)
    }

    private func canSendInDefaultAppMail() -> Bool {
        guard let url = URL(string: "mailto:some@mail.ru") else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }

    private func openDefaultAppMail(payload: MailSenderPayload) {
        let subjectEncoded = payload.subject?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let bodyEncoded = payload.body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""

        guard
            let mailUrl = URL(string: "mailto:\(payload.recipient)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        else {
            return
        }

        UIApplication.shared.open(mailUrl)
    }

}
