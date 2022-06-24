//
//  SkeletonViewViewController.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit
import Utils

final class SkeletonViewViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var skeletonView: SkeletonView!
    @IBOutlet private weak var view1: UIView!
    @IBOutlet private weak var view2: UIView!
    @IBOutlet private weak var view3: UIView!
    @IBOutlet private weak var view4: UIView!

    // MARK: - Properties

    var output: SkeletonViewViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - SkeletonViewViewInput

extension SkeletonViewViewController: SkeletonViewViewInput {

    func setupInitialState() {
        configureSkeletonView()
    }

}

// MARK: - Private Methods

private extension SkeletonViewViewController {

    func configureSkeletonView() {
        let views = [view1, view2, view3, view4]
        // Устанавливаем какие view(разрешены только subview данного skeletonView)
        // должны участвовать в анимации(по умолчанию все subviews)
        skeletonView.maskingViews = views.compactMap { view in
            view?.layer.cornerRadius = 10
            return view
        }

        // Направление в котором бегает шиммер(по умолчанию - вправо)
        skeletonView.direction = .left

        // Цвет, которым закрашиваются эти самые maskingViews
        skeletonView.gradientBackgroundColor = UIColor.lightGray

        // Цвет бегающего по ним шиммера
        skeletonView.gradientMovingColor = UIColor.green

        // Отношение ширины шиммера к ширине view. Допустимы значения в диапазоне [0.0, 1.0]
        skeletonView.shimmerRatio = 0.7

        // Длительность одного пробега шиммера в секундах
        skeletonView.movingAnimationDuration = 1.0

        // Длительность задержки между шагами анимации в секундах
        skeletonView.delayBetweenAnimationLoops = 1.0

        // Запускаем анимацию на всех вьюхах включенных в SkeletonView
        skeletonView.shimmering = true
    }

}
