//
//  CustomSwitch.swift
//  Utils
//
//  Created by Artemii Shabanov on 13.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

/// Flexible implementation of switch control
public class CustomSwitch: UIControl {

    // MARK: - Configuration Structures

    /// Contains parameters to define CustomSwitch padding(thumb to bounds),
    /// spacing(thumb to left/right sides) and cornerRatio
    public struct LayoutConfiguration {
        let padding: CGFloat
        let spacing: CGFloat
        let cornerRatio: CGFloat

        init(padding: CGFloat = 2,
             spacing: CGFloat = 2,
             cornerRatio: CGFloat = 0.5) {
            self.padding = padding
            self.spacing = spacing
            self.cornerRatio = cornerRatio
        }
    }

    /// Contains parameters to define CustomSwitch thumb cornerRatio and shadowConfiguration
    public struct ThumbConfiguration {
        let cornerRatio: CGFloat
        let shadowConfiguration: CSShadowConfiguration?

        init(cornerRatio: CGFloat = 0.5,
             shadowConfiguration: CSShadowConfiguration? = nil) {
            self.cornerRatio = cornerRatio
            self.shadowConfiguration = shadowConfiguration
        }
    }

    /// Contains parameters to define CustomSwitch color configurations(off/on states + thumb)
    public struct ColorsConfiguration {
        let offColor: CSColorConfiguration
        let onColor: CSColorConfiguration
        let thumbColor: CSColorConfiguration

        init(offColor: UIColor = .lightGray,
             onColor: UIColor = .systemGreen,
             thumbColor: UIColor = .white) {
            self.offColor = CSSimpleColorConfiguration(color: offColor)
            self.onColor = CSSimpleColorConfiguration(color: onColor)
            self.thumbColor = CSSimpleColorConfiguration(color: thumbColor)
        }

        init(offColorConfiguraion: CSColorConfiguration,
             onColorConfiguraion: CSColorConfiguration,
             thumbColorConfiguraion: CSColorConfiguration) {
            self.offColor = offColorConfiguraion
            self.onColor = onColorConfiguraion
            self.thumbColor = thumbColorConfiguraion
        }
    }

    /// Contains parameters to define CustomSwitch animations parameters
    public struct AnimationsConfiguration {
        let duration: Double
        let delay: Double
        let usingSpringWithDamping: CGFloat
        let initialSpringVelocity: CGFloat
        let options: UIView.AnimationOptions

        init(duration: Double = 0.5,
             delay: Double = 0,
             usingSpringWithDamping: CGFloat = 0.7,
             initialSpringVelocity: CGFloat = 0.5,
             options: UIView.AnimationOptions = [
                 UIView.AnimationOptions.curveEaseOut,
                 UIView.AnimationOptions.beginFromCurrentState,
                 UIView.AnimationOptions.allowUserInteraction
             ]) {
            self.duration = duration
            self.delay = delay
            self.usingSpringWithDamping = usingSpringWithDamping
            self.initialSpringVelocity = initialSpringVelocity
            self.options = options
        }
    }

    // MARK: - Public Properties

    /// Holds CustomSwitch basic layout parameters
    public var layoutConfiguration = LayoutConfiguration()
    /// Holds CustomSwitch thumb parameters
    public var thumbConfiguration = ThumbConfiguration()
    /// Holds CustomSwitch colors parameters
    public var colorsConfiguration = ColorsConfiguration()
    /// Holds CustomSwitch animations parameters
    public var animationsConfiguration = AnimationsConfiguration()
    /// True if switch is on
    public var isOn: Bool = true {
        didSet {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }

    // MARK: - Private Properties

    private var thumbView = UIView(frame: CGRect.zero)
    private var onView = UIView(frame: CGRect.zero)
    private var onPoint = CGPoint.zero
    private var offPoint = CGPoint.zero
    private var isAnimating = false

    // MARK: - UIControl

    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        animate()
        return true
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        if !isAnimating {
            // thumb management
            let thumbSize = CGSize(width: bounds.size.height - layoutConfiguration.spacing * 2,
                                   height: bounds.height - layoutConfiguration.spacing * 2)
            let yPostition = (bounds.size.height - thumbSize.height) / 2
            onPoint = CGPoint(x: bounds.size.width - thumbSize.width - layoutConfiguration.padding, y: yPostition)
            offPoint = CGPoint(x: layoutConfiguration.padding, y: yPostition)
            thumbView.frame = CGRect(origin: isOn ? onPoint : offPoint, size: thumbSize)
            thumbView.layer.cornerRadius = thumbSize.height * thumbConfiguration.cornerRatio

            // gradient management
            onView.frame = bounds

            // view management
            onView.layer.cornerRadius = bounds.height * layoutConfiguration.cornerRatio
            layer.cornerRadius = bounds.height * layoutConfiguration.cornerRatio
            onView.alpha = isOn ? 1 : 0

            setupUI()
        }
    }

    // MARK: Public Methods

    /// Set switch state
    /// - Parameters:
    ///   - on: switch state
    ///   - animated: using of animation on transiton
    public func setOn(_ on: Bool, animated: Bool) {
        switch animated {
        case true:
            animate(on: on)
        case false:
            isOn = on
            setupViewsOnAction()
            completeAction()
        }
    }

}

// MARK: Private Methods

private extension CustomSwitch {

    func setupUI() {
        // clear self before configuration
        clear()
        clipsToBounds = false

        // configure thumb view
        colorsConfiguration.thumbColor.applyColor(for: thumbView)
        thumbView.isUserInteractionEnabled = false
        if let thumbShadowConfiguration = thumbConfiguration.shadowConfiguration {
            thumbView.layer.shadowColor = thumbShadowConfiguration.color.cgColor
            thumbView.layer.shadowOffset = thumbShadowConfiguration.offset
            thumbView.layer.shadowRadius = thumbShadowConfiguration.radius
            thumbView.layer.shadowOpacity = thumbShadowConfiguration.oppacity
        }

        // configure gradient view
        colorsConfiguration.onColor.applyColor(for: onView)
        onView.isUserInteractionEnabled = false

        // configure super
        colorsConfiguration.offColor.applyColor(for: self)
        addSubview(onView)
        addSubview(thumbView)
    }

    func clear() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }

    func animate(on: Bool? = nil) {
        isOn = on ?? !isOn
        isAnimating = true
        UIView.animate(withDuration: animationsConfiguration.duration,
                       delay: animationsConfiguration.delay,
                       usingSpringWithDamping: animationsConfiguration.usingSpringWithDamping,
                       initialSpringVelocity: animationsConfiguration.initialSpringVelocity,
                       options: animationsConfiguration.options,
                       animations: {
                           self.setupViewsOnAction()
                       },
                       completion: { _ in
                           self.completeAction()
                       })
    }

    func setupViewsOnAction() {
        thumbView.frame.origin.x = isOn ? onPoint.x : offPoint.x
        onView.alpha = isOn ? 1 : 0
    }

    func completeAction() {
        isAnimating = false
        sendActions(for: UIControl.Event.valueChanged)
    }

}
