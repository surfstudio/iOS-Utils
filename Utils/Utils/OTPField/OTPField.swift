//
//  OTPField.swift
//  Utils
//
//  Created by Anton Dryakhlykh on 15.10.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

public class OTPField: UIView {

    // MARK: - IBOutlets

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var errorLabel: UILabel!

    // MARK: - Nested

    public enum State {
        case `default`
        case error(message: String)
    }

    // MARK: - Public Properties

    public var didCodeEnter: ((String) -> Void)?
    public private(set) var text = ""
    private var state: State = .default
    private var style = OTPFieldStyle()
    private var digitSize = CGSize(width: 32.0, height: 32.0)
    private var betweenDigitsSpace: CGFloat = 6.0
    private var maxLength: Int {
        return digits.count
    }
    private var digits: [DigitField] {
        return stackView.subviews as? [DigitField] ?? []
    }

    // MARK: - Lifecycle

    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        configureInitialState()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        configureInitialState()
    }

    // MARK: - Internal helpers

    public func clear() {
        text = ""

        digits.forEach { digit in
            digit.text = nil
            digit.configure(for: .inactive)
        }
    }

    public func showError(message: String) {
        configure(for: .error(message: message))
    }

    public func clearError() {
        configure(for: .default)
    }

    public func setDigits(count: Int) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for _ in 0..<count {
            let digit = DigitField()
            digit.set(style: style.digitStyle)
            digit.set(size: digitSize)
            stackView.addArrangedSubview(digit)
        }

        configureInitialState()
    }

    public func set(style: OTPFieldStyle) {
        errorLabel.textColor = style.errorTextColor
        errorLabel.font = style.errorFont

        self.style = style
        digits.forEach { $0.set(style: style.digitStyle) }
    }

    public func setDigit(size: CGSize) {
        self.digitSize = size
        digits.forEach { $0.set(size: size) }
    }

    public func setBetween(space: CGFloat) {
        stackView.spacing = space
    }

    public func showKeyboard() {
        digits.first?.becomeFirstResponder()
    }

    public func hideKeyboard() {
        digits.first?.resignFirstResponder()
    }

    // MARK: - Private Methods

    private func configure(for state: State) {
        switch state {
        case .default:
            errorLabel.isHidden = true
            digits.forEach { digit in
                if let text = digit.text, !text.isEmpty {
                    digit.configure(for: .active)
                } else {
                    digit.configure(for: .inactive)
                }
            }
        case .error(let message):
            errorLabel.isHidden = false
            errorLabel.text = message
            digits.forEach { $0.configure(for: .error) }
        }
    }

    private func configureInitialState() {
        errorLabel.textColor = style.errorTextColor
        errorLabel.font = style.errorFont
        errorLabel.textAlignment = .center
        backgroundColor = UIColor.white.withAlphaComponent(0.0)
        digits.first?.delegate = self
        digits.first?.becomeFirstResponder()
        digits.forEach { digit in
            if digit != self.digits.first {
                digit.isUserInteractionEnabled = false
            }
        }
        clear()
        configure(for: .default)
    }
}

// MARK: - UITextFieldDelegate

extension OTPField: UITextFieldDelegate {
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {

        if string == "" {
            guard !text.isEmpty else { return false }

            text = String(text.dropLast())
            digits[self.text.count].text = nil

            configure(for: .default)

            return false
        } else {
            guard self.text.count < self.maxLength else { return false }

            digits[self.text.count].text = string

            self.text += string

            if self.text.count == self.maxLength {
                didCodeEnter?(self.text)
            }

            configure(for: .default)

            textField.text = digits.first?.text
            return false
        }
    }
}
