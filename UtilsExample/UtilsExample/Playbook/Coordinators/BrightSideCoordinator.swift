//
//  BrightSideCoordinator.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 24.06.2022.
//

import SurfPlaybook

final class BrightSideCoordinator: PlaybookFlowCoordinator {

    // MARK: - Private Properties

    private let router = MainRouter()

    // MARK: - PlaybookFlowCoordinator

    var id: String {
        return "BrightSideCoordinator"
    }

    var name: String {
        return "BrightSideCoordinator"
    }

    var type: FlowCoordinatorType {
        return .coordinator { [weak self] in
            let (view, _) = BrightSideModuleConfigurator().configure()
            self?.router.present(view)
        }
    }

}
