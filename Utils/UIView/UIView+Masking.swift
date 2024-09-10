//
//  UIView+Masking.swift
//  Utils
//
//  Created by Artemii Shabanov on 21/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIView {

    /// Apply given views as masks
    ///
    /// - Parameter views: Views to apply as mask.
    /// ## Note: The view calling this function must have all the views in the given array as subviews.
    public func setMaskingViews(_ views: [UIView]) {

        let mutablePath = CGMutablePath()

        //Append path for each subview
        views.forEach { (view) in
            guard self.subviews.contains(view) else {
                fatalError("View:\(view) is not a subView of \(self). Therefore, it cannot be a masking view.")
            }
            let path = UIBezierPath(roundedRect: view.frame, cornerRadius: view.layer.cornerRadius)
            mutablePath.addPath(path.cgPath)
        }

        let maskLayer = CAShapeLayer()
        maskLayer.path = mutablePath

        self.layer.mask = maskLayer
    }

}
