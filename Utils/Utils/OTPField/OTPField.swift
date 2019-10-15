//
//  OTPField.swift
//  Utils
//
//  Created by Anton Dryakhlykh on 15.10.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

final class OTPField: UIView {

    // MARK: - IBOutlets

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var errorLabel: UILabel!

    // MARK: - Enums

    enum State {
        case `default`
        case error(message: String)
    }

    private enum Constants {
        static let maxLength = 4
        static let errorFontSize: CGFloat = 12.0
    }

    // MARK: - Public Properties

    var didCodeEnter: ((String) -> ())?
    private(set) var text = ""
    private var state: State = .default
    private var labels: [OTPLabel] {
        return stackView.subviews as? [OTPLabel] ?? []
    }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        configureInitialState()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        configureInitialState()
    }

    // MARK: - UIKit

    override var canBecomeFirstResponder: Bool {
        return true
    }

    // MARK: - Internal helpers

    func clear() {
        text = ""

        stackView.subviews.forEach { label in
            guard let label = label as? OTPLabel else { return }

            label.text = nil
            label.configure(for: .inactive)
        }
    }

    func showError(message: String) {
        configure(for: .error(message: message))
    }

    func clearError() {
        configure(for: .default)
    }

    func setError(textColor: UIColor, font: UIFont) {
        errorLabel.textColor = textColor
        errorLabel.font = font
    }

    // MARK: - Private Methods

    private func configure(for state: State) {
        switch state {
        case .default:
            errorLabel.isHidden = true
            labels.forEach { label in
                if let text = label.text, !text.isEmpty {
                    label.configure(for: .active)
                } else {
                    label.configure(for: .inactive)
                }
            }
        case .error(let message):
            errorLabel.isHidden = false
            errorLabel.text = message
            labels.forEach { $0.configure(for: .error) }
        }
    }

    private func configureInitialState() {
        becomeFirstResponder()
        clear()
        configure(for: .default)
    }
}

// MARK: - UIKeyInput

extension OTPField: UIKeyInput {
    var hasText: Bool {
        return !text.isEmpty
    }

    func insertText(_ text: String) {
        guard self.text.count < Constants.maxLength else { return }

        labels[self.text.count].text = text

        self.text += text

        if self.text.count == Constants.maxLength {
            didCodeEnter?(self.text)
        }

        configure(for: .default)
    }

    func deleteBackward() {
        guard !text.isEmpty else { return }

        text = String(text.dropLast())
        labels[self.text.count].text = nil

        configure(for: .default)
    }
}

// MARK: - UITextInputTraits

// swiftlint:disable unused_setter_value
extension OTPField: UITextInputTraits {
    var keyboardType: UIKeyboardType {
        get {
            return .numberPad
        }
        set {
            assertionFailure()
        }
    }
}
// swiftlint:enable unused_setter_value
