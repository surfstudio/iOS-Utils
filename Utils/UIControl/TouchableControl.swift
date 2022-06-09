//
//  TouchableControl.swift
//  TouchableControlTest
//
//  Created by Сергей Полозов on 03.03.2020.
//  Copyright © 2020 Сергей Полозов. All rights reserved.
//

import UIKit

open class TouchableControl: UIControl {

    // MARK: - Typealiases

    private typealias ColoredView = (view: UIView, normalColor: UIColor, touchedColor: UIColor)

    // MARK: - Constants

    private enum Constants {
        static let initialAlhpaValue: CGFloat = 1
    }

    // MARK: - Public Properties

    public var animatingViewsByAlpha: [UIView]?

    public var onTouchUpInside: (() -> Void)?
    public var onTouchCancel: (() -> Void)?
    public var onTouchDown: (() -> Void)?

    public var touchAlphaValue: CGFloat = 0.7
    public var animationDuration: TimeInterval = 0.2

    // MARK: - Private Properties

    private var animating = false
    private var shouldAnimateBack = false
    private var coloredViews = [ColoredView]()

    // MARK: - Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }

    // MARK: - Public Properties

    public func addChangeColor(to view: UIView, normalColor: UIColor?, touchedColor: UIColor?) {
        let realInitColor = normalColor ?? .black
        let realGoalColor = touchedColor ?? .black
        coloredViews.append((view, realInitColor, realGoalColor))
    }

    // Для случаев, когда данный класс добавлен во вью, которая будет менять свои свойства
    // из-за данного класса. Устонавливается в deinit ViewController'а с этой view
    public func clearControl() {
        animatingViewsByAlpha = nil
        coloredViews = []
    }
}

// MARK: - Private Methods

private extension TouchableControl {

    func configureView() {
        addActions()
    }

    func addActions() {
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUpinside), for: .touchUpInside)
        addTarget(self, action: #selector(touchCancel), for: .touchCancel)
        addTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
    }

    @objc
    func touchCancel() {
        onTouchCancel?()
        animateBack()
    }

    @objc
    func touchDragExit() {
        animateBack()
    }

    @objc
    func touchDown() {
        onTouchDown?()
        animateDown()
    }

    @objc
    func touchUpinside() {
        animateBack()
        onTouchUpInside?()
    }

    func animateDown() {
        guard !animating else { return }
        animating = true

        let animations: () -> Void = {
            self.alpha = self.touchAlphaValue
            self.animatingViewsByAlpha?.forEach { (view) in
                view.alpha = self.touchAlphaValue
            }
            self.coloredViews.forEach { (view, _, touchedColor) in
                if let label = view as? UILabel {
                    label.textColor = touchedColor
                } else {
                    view.backgroundColor = touchedColor
                }
            }
        }

        let completion: (Bool) -> Void = {_ in
            self.animating = false
            if self.shouldAnimateBack {
                self.animateBack()
            }
        }

        UIView.animate(
            withDuration: animationDuration,
            animations: animations,
            completion: completion
        )
    }

    func animateBack() {
        guard !animating else {
            shouldAnimateBack = true
            return
        }
        animating = true

        let animations: () -> Void = {
            self.alpha = Constants.initialAlhpaValue
            self.animatingViewsByAlpha?.forEach({ (view) in
                view.alpha = Constants.initialAlhpaValue
            })
            self.coloredViews.forEach { (view, normalColor, _) in
                if let label = view as? UILabel {
                    label.textColor = normalColor
                } else {
                    view.backgroundColor = normalColor
                }
            }
        }

        let completion: (Bool) -> Void = {_ in
            self.animating = false
            self.shouldAnimateBack = false
        }

        UIView.animate(
            withDuration: animationDuration,
            animations: animations,
            completion: completion
        )
    }
}
