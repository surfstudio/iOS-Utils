//
//  TouchableControl.swift
//  TouchableControlTest
//
//  Created by Сергей Полозов on 03.03.2020.
//  Copyright © 2020 Сергей Полозов. All rights reserved.
//

import UIKit

public class TouchableControl: UIControl {

    // MARK: - Constants

    private enum Constants {
        static let normalAlhpaValue: CGFloat = 1
    }

    // MARK: - Public Properties

    open var animatingViewsByAlpha: [UIView]?

    open var onTouchUpInside: (() -> Void)?
    open var onTouchCancel: (() -> Void)?
    open var onTouchDown: (() -> Void)?

    open var touchAlphaValue: CGFloat = 0.7
    open var normalDuration: TimeInterval = 0.2

    // MARK: - Private Properties

    private var animating = false
    private var shouldAnimateBack = false
    private var coloredViews: [(UIView, UIColor, UIColor)]?

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

    open func addChangeColor(to view: UIView, initColor: UIColor?, goalColor: UIColor?) {
        let realInitColor = initColor ?? .black
        let realGoalColor = goalColor ?? .black
        if coloredViews == nil {
            coloredViews = [(view, realInitColor, realGoalColor)]
        } else {
            coloredViews?.append((view, realInitColor, realGoalColor))
        }
    }

    // Для случаев, когда данный класс добавлен во вью, которая будет сама
    // передана в него. Устонавливается в deinit ViewController'а с этой view
    open func clearControl() {
        animatingViewsByAlpha = nil
        coloredViews = nil
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
    private func touchDragExit() {
        animateBack()
    }

    @objc
    private func touchDown() {
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
            self.coloredViews?.forEach { (view, _, goalColor) in
                if let label = view as? UILabel {
                    label.textColor = goalColor
                } else {
                    view.backgroundColor = goalColor
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
            withDuration: normalDuration,
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
            self.alpha = Constants.normalAlhpaValue
            self.animatingViewsByAlpha?.forEach({ (view) in
                view.alpha = Constants.normalAlhpaValue
            })
            self.coloredViews?.forEach { (view, initColor, _) in
                if let label = view as? UILabel {
                    label.textColor = initColor
                } else {
                    view.backgroundColor = initColor
                }
            }
        }

        let completion: (Bool) -> Void = {_ in
            self.animating = false
            self.shouldAnimateBack = false
        }

        UIView.animate(
            withDuration: normalDuration,
            animations: animations,
            completion: completion
        )
    }
}
