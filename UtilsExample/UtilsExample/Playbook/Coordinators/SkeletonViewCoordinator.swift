//
//  SkeletonViewCoordinator.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 24.06.2022.
//

import SurfPlaybook

final class SkeletonViewCoordinator: PlaybookFlowCoordinator {

    // MARK: - Private Properties

    private let router = MainRouter()

    // MARK: - PlaybookFlowCoordinator

    var id: String {
        return "SkeletonViewCoordinator"
    }

    var name: String {
        return "SkeletonViewCoordinator"
    }

    var type: FlowCoordinatorType {
        return .coordinator { [weak self] in
            let (view, _) = SkeletonViewModuleConfigurator().configure()
            self?.router.present(view)
        }
    }

}
