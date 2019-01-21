//
//  Created by Artemii Shabanov on 18/01/2019.
//  Copyright © 2019 Roni Leshes. All rights reserved.
//

import UIKit

/// View for skeleton loaders
open class SkeletonView: UIView {

    // MARK: - Properties

    // MARK: Masking

    /// ## Note: Only subviews of current SkeletonView can be added to maskingViews
    var maskingViews: [UIView] = [] {
        didSet {
            setMaskingViews(maskingViews)
        }
    }

    // MARK: Animation time

    var movingAnimationDuration : CFTimeInterval = 0.5
    var delayBetweenAnimationLoops : CFTimeInterval = 1.0


    // MARK: Animation Logic

    /// Property is set to .right by default
    var direction: ShimmeringDirection = .right {
        didSet {
            gradientLayer.locations = startLocations
        }
    }
    /// Set this property to true to start shimmering
    var shimmering = false {
        didSet {
            if shimmering {
                startAnimating()
            } else {
                stopAnimating()
            }
        }
    }
    /// Provides different values of shimmer width
    var shimmerWidth: GradientWidth = .default {
        didSet {
            (leftLocations, rightLoactions) = shimmerWidth.gradientLocations
        }
    }


    // MARK: Colors

    var gradientBackgroundColor: CGColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor {
        didSet {
            updateColors()
        }
    }
    var gradientMovingColor: CGColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor {
        didSet {
            updateColors()
        }
    }

    // MARK: - Private Properties

    private var leftLocations:  [NSNumber] = []
    private var rightLoactions: [NSNumber] = []
    private var gradientLayer: CAGradientLayer!

    // MARK: - UIView

    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        configureGradientLayer()
        updateColors()
        maskingViews = subviews
        shimmerWidth = .default
    }
    
}

// MARK: - Private Methods and Computed Properties

private extension SkeletonView {

    var startLocations: [NSNumber] {
        switch direction {
        case .right:
            return leftLocations
        case .left:
            return rightLoactions
        }
    }

    var endLocations: [NSNumber] {
        switch direction {
        case .right:
            return rightLoactions
        case .left:
            return leftLocations
        }
    }

    func startAnimating(){
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = startLocations
        animation.toValue = endLocations
        animation.duration = movingAnimationDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = movingAnimationDuration + delayBetweenAnimationLoops
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        gradientLayer.add(animationGroup, forKey: animation.keyPath)
    }

    func stopAnimating() {
        gradientLayer.removeAllAnimations()
    }

    func updateColors() {
        gradientLayer.colors = [
            gradientBackgroundColor,
            gradientMovingColor,
            gradientBackgroundColor
        ]
    }

    func configureGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = startLocations
        layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
    }

}
