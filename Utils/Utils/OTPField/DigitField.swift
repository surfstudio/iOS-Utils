//
//  DigitField.swift
//  Utils
//
//  Created by Anton Dryakhlykh on 16.10.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

public class DigitField: UITextField {

    // MARK: - Nested

    public enum FieldState {
        case active
        case inactive
        case error
    }

    // MARK: - Constants

    private enum Constants {
        static let fontSize: CGFloat = 24.0
        static let bottomHeight: CGFloat = 1.0
        static let bottomLineTopPadding: CGFloat = 16.0
    }

    // MARK: - Private Properties

    private let bottomLineView = UIView()
    private var fieldState = FieldState.inactive
    private var style = DigitFieldStyle()
    private var size = CGSize(width: 32.0, height: 32.0)
    private var widthConstraint = NSLayoutConstraint()
    private var heightConstraint = NSLayoutConstraint()

    // MARK: - Lifecycle

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    public override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }

    // MARK: - Public Methods

    public func configure(for state: FieldState) {
        switch state {
        case .active:
            textColor = style.activeTextColor
            bottomLineView.backgroundColor = style.activeBottomLineColor
        case .inactive:
            textColor = style.inactiveTextColor
            bottomLineView.backgroundColor = style.inactiveBottomLineColor
        case .error:
            textColor = style.errorTextColor
            bottomLineView.backgroundColor = style.errorBottomLineColor
        }

        self.fieldState = state
    }

    public func set(style: DigitFieldStyle) {
        self.style = style
        self.configure(for: fieldState)
        self.font = style.font
    }

    public func set(size: CGSize) {
        self.size = size
        widthConstraint.constant = size.width
        widthConstraint.constant = size.height
    }

    // MARK: - Private Methods

    private func configure() {
        addBottomLine()
        textColor = style.inactiveTextColor
        backgroundColor = .clear
        textAlignment = .center
        borderStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false

        keyboardType = .numberPad

        if #available(iOS 12.0, *) {
            textContentType = .oneTimeCode
        }

        widthConstraint = widthAnchor.constraint(equalToConstant: size.width)
        heightConstraint = heightAnchor.constraint(equalToConstant: size.height)

        NSLayoutConstraint.activate([
            widthConstraint,
            heightConstraint
        ])
    }

    private func addBottomLine() {
        bottomLineView.backgroundColor = style.inactiveBottomLineColor
        bottomLineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomLineView)
        NSLayoutConstraint.activate([
            bottomLineView.heightAnchor.constraint(equalToConstant: Constants.bottomHeight),
            bottomLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomLineView.topAnchor.constraint(equalTo: bottomAnchor,
                                                constant: Constants.bottomLineTopPadding)
        ])
    }
}
