//
//  ActionableLabelCoordinator.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 24.06.2022.
//

import SurfPlaybook

final class ActionableLabelCoordinator: PlaybookFlowCoordinator {

    // MARK: - Private Properties

    private let router = MainRouter()

    // MARK: - PlaybookFlowCoordinator

    var id: String {
        return "ActionableLabelCoordinator"
    }

    var name: String {
        return "ActionableLabelCoordinator"
    }

    var type: FlowCoordinatorType {
        return .coordinator { [weak self] in
            let (view, _) = ActionableLabelModuleConfigurator().configure()
            self?.router.present(view)
        }
    }

}
