//
//  BeanPageControl.swift
//  Utils
//
//  Created by Artemii Shabanov on 19.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

/// Bean-like page control with support of progress indication
public final class BeanPageControl: UIView {

    // MARK: - Nested Types

    private enum Direction {
        case left
        case right

        var multiplier: Int {
            switch self {
            case .right:
                return 1
            case .left:
                return -1
            }
        }
    }

    // MARK: - Private Properties

    private var beans: [UIView] = []
    private var animatorIndex: Int = 0
    private var direction = Direction.right
    private var animator: UIViewPropertyAnimator?

    // MARK: - Public Properties

    public var count: Int = 0 {
        didSet {
            updateBeans()
        }
    }

    public var beanHeight: CGFloat = 6.0 {
        didSet {
            updateBeans()
        }
    }
    public var inactiveBeanWidth: CGFloat = 6.0 {
       didSet {
           updateBeans()
       }
    }
    public var activeBeanWidth: CGFloat = 25.0 {
       didSet {
           updateBeans()
       }
    }
    public var padding: CGFloat = 4.0 {
       didSet {
           updateBeans()
       }
    }
    public var beanCornerRadius: CGFloat = 3.0 {
       didSet {
           updateBeans()
       }
    }
    public var beanActiveColor = UIColor.black {
       didSet {
           updateBeans()
       }
    }
    public var beanInactiveColor = UIColor.lightGray {
       didSet {
           updateBeans()
       }
    }

    // MARK: - Public Methods

    /// Controls page control state/progress
    /// - Parameters:
    ///   - index: current page
    ///   - progress: progress to the next page(0.0 - 1.0).
    public func set(index: Int,
                    progress: CGFloat = 0) {
        if animator == nil {
            updateAnimator()
        }

        if (index == 0 && progress < 0) || (index == count - 1 && progress > 0) {
            animatorIndex = index
            update(direction: (index == count - 1) ? .left: .right)
            return
        }

        if direction == .right && index > animatorIndex {
            animatorIndex = index
            update(direction: (index == count - 1) ? .left: .right)
        }

        if direction == .right && index < animatorIndex {
            if animatorIndex - index > 1 {
                animatorIndex = index
            }
            update(direction: .left)
        }

        if direction == .left && index + 1 <= animatorIndex {
            animatorIndex = index
            update(direction: (index == 0) ? .right : .left)
        }

        if direction == .left && index + 1 >= animatorIndex && animatorIndex != count - 1 {
            if index - animatorIndex > 1 {
                animatorIndex = index
            }
            update(direction: .right)
        }

        if progress != 0 {
            updateAnimator(progress: progress)
        }
    }

    // MARK: - UIView

    public override var intrinsicContentSize: CGSize {
        return calculateSize()
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateBeans()
    }

    override public func willMove(toWindow newWindow: UIWindow?) {
        // rest animator on return to screen with BeanPageControl
        guard newWindow != nil else {
            return
        }
        updateBeans()
    }

    // MARK: - Deinitialization

    deinit {
        animator?.stopAnimation(true)
        animator?.finishAnimation(at: .current)
    }

}

// MARK: - Layout

private extension BeanPageControl {

    func updateBeans() {
        beans.forEach { $0.removeFromSuperview() }
        beans.removeAll()

        beans = stride(from: 0, to: count, by: 1).map { _ in configureEmptyView() }
        layoutBeans()
        animator = nil

        invalidateIntrinsicContentSize()
    }

    func configureEmptyView() -> UIView {
        let view = UIView()
        view.backgroundColor = beanInactiveColor
        self.addSubview(view)
        return view
    }

    func layoutBeans() {
        animator?.stopAnimation(true)
        animator?.finishAnimation(at: .end)
        var layerFrame: CGRect = .zero
        for (index, layer) in beans.enumerated() {
            let indicatorWidth = index == animatorIndex
                ? activeBeanWidth
                : inactiveBeanWidth
            let indicatorColor = index == animatorIndex
                ? beanActiveColor
                : beanInactiveColor
            layer.backgroundColor = indicatorColor
            layer.layer.cornerRadius = beanCornerRadius
            layer.frame = CGRect(x: layerFrame.origin.x,
                                 y: layerFrame.origin.y,
                                 width: indicatorWidth,
                                 height: beanHeight)
            layerFrame = layer.frame
            layerFrame.origin.x += indicatorWidth + padding
        }
    }

    func calculateSize() -> CGSize {
        let inactiveIndicatorsWidth = CGFloat(beans.count - 1) * inactiveBeanWidth
        let indicatorPadding = padding * CGFloat(beans.count - 1)
        let calculatedWidth
            = indicatorPadding
            + inactiveIndicatorsWidth
            + activeBeanWidth
        return CGSize(width: calculatedWidth,
                      height: beanHeight)
    }

}

// MARK: - Help Methods

private extension BeanPageControl {

    private func update(direction: Direction) {
        self.direction = direction
        layoutBeans()
        updateAnimator()
    }

    func updateAnimator(progress: CGFloat) {
        if direction == .left {
            animator?.fractionComplete = 1 - progress
        } else {
            animator?.fractionComplete = progress
        }
    }

    func updateAnimator() {
        animator = createAnimatorBetween(startBean: beans[animatorIndex],
                                         endBean: beans[animatorIndex + direction.multiplier])
    }

    func createAnimatorBetween(startBean: UIView, endBean: UIView) -> UIViewPropertyAnimator {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)

        let startFrame = CGRect(x: calculateStartX(fromFrame: startBean.frame),
                                y: startBean.frame.origin.y,
                                width: inactiveBeanWidth,
                                height: startBean.frame.height)

        let endFrame = CGRect(x: calculateEndX(fromFrame: startBean.frame),
                              y: endBean.frame.origin.y,
                              width: activeBeanWidth,
                              height: endBean.frame.height)

        animator.addAnimations {
            startBean.backgroundColor = self.beanInactiveColor
            startBean.frame = startFrame
            endBean.backgroundColor = self.beanActiveColor
            endBean.frame = endFrame

            self.layoutIfNeeded()
        }
        animator.startAnimation()
        animator.pauseAnimation()

        return animator
    }

    func calculateStartX(fromFrame: CGRect) -> CGFloat {
        if direction == .left {
            return fromFrame.origin.x + activeBeanWidth - inactiveBeanWidth
        } else {
            return fromFrame.origin.x
        }
    }

    func calculateEndX(fromFrame: CGRect) -> CGFloat {
         return fromFrame.origin.x + CGFloat(direction.multiplier) * (inactiveBeanWidth + padding)
    }

}
