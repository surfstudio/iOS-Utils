//
//  CommonButton.swift
//  Utils
//
//  Created by Александр Чаусов on 28/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

open class CommonButton: UIButton {

    // MARK: - Public Properties

    public var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    /// Increase touch area
    public var addedTouchArea: CGFloat = 0.0

    // MARK: - Initialization

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - UIButton

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let newBound = CGRect(
            x: bounds.origin.x - addedTouchArea,
            y: bounds.origin.y - addedTouchArea,
            width: bounds.width + 2 * addedTouchArea,
            height: bounds.height + 2 * addedTouchArea
        )
        return newBound.contains(point)
    }

    // MARK: - Public Methods

    /// Method set title for all states
    public func setTitleForAllState(_ title: String?) {
        setTitle(title, for: .normal)
        setTitle(title, for: .disabled)
        setTitle(title, for: .highlighted)
        setTitle(title, for: .selected)
    }

    /// Method set image for all states
    /// If use alpha image with alpha mask will set for disabled, highlighted, selected states
    /// - Parameters:
    ///     - image: Optional value for set button image
    ///     - alpha: Optional value for disabled, highlighted, selected states
    public func setImageForAllState(_ image: UIImage?, alpha: CGFloat? = nil) {
        let highlightedImage = alpha != nil
            ? image?.mask(with: alpha ?? 0)
            : image
        setImage(image, for: .normal)
        setImage(highlightedImage, for: .disabled)
        setImage(highlightedImage, for: .highlighted)
        setImage(highlightedImage, for: .selected)
    }

    /// Method will set background color for control state
    public func set(backgroundColor: UIColor, for state: UIControl.State) {
        setBackgroundImage(UIImage(color: backgroundColor), for: state)
    }

    /// Method will set background color for all choosed control states
    public func set(backgroundColor: UIColor, for states: [UIControl.State]) {
        states.forEach { setBackgroundImage(UIImage(color: backgroundColor), for: $0) }
    }

    /// Method will set title color for all choosed control states
    public func set(titleColor: UIColor, for states: [UIControl.State]) {
        states.forEach { setTitleColor(titleColor, for: $0) }
    }

}
