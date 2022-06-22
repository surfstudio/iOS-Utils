//
//  LoadingView.swift
//  Utils
//
//  Created by Никита Гагаринов on 18.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

open class BaseLoadingView: UIView, LoadingView {

    // MARK: - Constants

    private enum Constants {
        static let gradientColorFrom = UIColor.white.withAlphaComponent(0)
        static let gradientColorTo = UIColor.white.withAlphaComponent(1)
        static let gradientLocations: [NSNumber] = [0.5, 0.95]
    }

    // MARK: - Properties

    open var blocks: [LoadingViewBlock] = []
    open var config = LoadingViewConfig(placeholderColor: .white)
    open var topOffset: CGFloat = 0
    open var skeletonView = SkeletonView()
    open var gradientContainer = UIView()
    open var gradientLayer = CAGradientLayer()

    // MARK: - Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAppearance()
    }

    // MARK: - UIView

    override open func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = gradientContainer.bounds
    }

    // MARK: - Open Methods

    open func configure(blocks: [LoadingViewBlock], config: LoadingViewConfig) {
        removeOldBlocks()
        self.blocks = blocks
        self.config = config
        self.topOffset = config.topOffset

        configureSkeletonView()
        repeatLastIfNeeded()
        addBlocksToView()

        bringSubviewToFront(skeletonView)
        bringSubviewToFront(gradientContainer)
        gradientContainer.isHidden = !config.needGradient
        setupConstraints()
    }

    // MARK: - LoadingView

    open func setNeedAnimating(_ needAnimating: Bool) {
        skeletonView.shimmering = needAnimating
    }

}

// MARK: - Appearance

private extension BaseLoadingView {

    func configureAppearance() {
        backgroundColor = .white
        configureGradient()
    }

    func configureSkeletonView() {
        addSubview(skeletonView)
        self.stretch(view: skeletonView)

        let skeletonSubview = UIView()
        skeletonView.addSubview(skeletonSubview)

        [skeletonView, skeletonSubview].forEach { $0.backgroundColor = .clear }
        skeletonView.stretch(view: skeletonSubview)

        skeletonView.maskingViews = [skeletonSubview]
        skeletonView.gradientBackgroundColor = config.shimmerColor.withAlphaComponent(0)
        skeletonView.gradientMovingColor = config.shimmerColor.withAlphaComponent(0.5)
        skeletonView.shimmerRatio = config.shimmerRatio
        skeletonView.movingAnimationDuration = config.movingAnimationDuration
    }

    func configureGradient() {
        addSubview(gradientContainer)
        self.stretch(view: gradientContainer)

        gradientLayer.colors = [
            Constants.gradientColorFrom.cgColor,
            Constants.gradientColorTo.cgColor
        ]
        gradientLayer.locations = Constants.gradientLocations

        gradientContainer.backgroundColor = UIColor.clear
        gradientContainer.layer.addSublayer(gradientLayer)
    }

}

// MARK: - Private Methods

private extension BaseLoadingView {

    func repeatLastIfNeeded() {
        // repeat last subview if there are few subviews
        guard config.needRepeatLast else {
            return
        }
        let subviewsHeight = blocks.flatMap({ $0.getSubviews() }).map({ $0.height }).reduce(0, +)
        let screenHeight = UIScreen.main.bounds.height
        if subviewsHeight < screenHeight {
            let diff = screenHeight - subviewsHeight
            guard
                let lastBlock = blocks.last,
                let lastView = lastBlock.getSubviews().last
            else {
                return
            }
            let lastViewHeight = lastView.height
            let countBlocksToAdd = Int((diff / lastViewHeight).rounded(.down)) + 1
            let repeatCount = lastBlock.repeatCount + countBlocksToAdd
            blocks.removeLast()
            blocks.append(lastBlock.reconfigure(repeatCount: repeatCount))
        }
    }

    func addBlocksToView() {
        blocks.forEach { block in
            block.getSubviews().forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                addSubview($0)
            }
            block.configure(color: config.placeholderColor)
        }
    }

    func setupConstraints() {
        var prev: UIView?
        for view in blocks.flatMap({ $0.getSubviews() }) {
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: prev?.bottomAnchor ?? topAnchor,
                                          constant: prev == nil ? topOffset : 0),
                view.leftAnchor.constraint(equalTo: leftAnchor),
                view.rightAnchor.constraint(equalTo: rightAnchor),
                view.heightAnchor.constraint(equalToConstant: view.height)
            ])
            prev = view
            view.layoutIfNeeded()
        }
    }

    func removeOldBlocks() {
        blocks.flatMap({ $0.getSubviews() }).forEach {
            $0.removeFromSuperview()
        }
        blocks.removeAll()
    }

}
