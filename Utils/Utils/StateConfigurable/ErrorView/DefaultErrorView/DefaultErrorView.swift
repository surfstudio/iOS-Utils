//
//  File.swift
//  Utils
//
//  Created by Никита Гагаринов on 30.10.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

final class DefaultErrorView: UIView, ErrorView {

    // MARK: - IBOutlets

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var contentView: UIView!

    // MARK: - Constraints

    @IBOutlet private weak var messageTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var iconWidthConstraint: NSLayoutConstraint!

    // MARK: - Properties

    var state: ErrorViewState = .error
    var onAction: ((ErrorViewState) -> Void)?

    // MARK: - UIView

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAppearance()
    }

    // MARK: - Public methods

    func configure(info: ViewStateInfo, config: ViewStateConfiguration, state: ErrorViewState) {
        self.state = state
        messageLabel.text = info.message
        actionButton.setTitle(info.actionText, for: .normal)

        messageTopConstraint.constant = config.messageTopOffset
        iconWidthConstraint.constant = config.iconWidth
        messageLabel.apply(style: config.messageStyle)
        actionButton.apply(style: config.actionStyle)
        iconImageView.image = config.icon
    }

}

// MARK: - IBActions

extension DefaultErrorView {

    @IBAction private func didActionTapped(_ sender: Any) {
        onAction?(state)
    }

}

// MARK: - Private Configuration

private extension DefaultErrorView {

    func configureAppearance() {
        xibSetup()
        containerView.backgroundColor = .clear
    }

}
