//
//  CustomSwitchCoordinator.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 23.06.2022.
//

import SurfPlaybook

final class CustomSwitchCoordinator: PlaybookFlowCoordinator {

    // MARK: - Private Properties

    private let router = MainRouter()

    // MARK: - PlaybookFlowCoordinator

    var id: String {
        return "CustomSwitchCoordinator"
    }

    var name: String {
        return "CustomSwitchCoordinator"
    }

    var type: FlowCoordinatorType {
        return .coordinator { [weak self] in
            let (view, _) = CustomSwitchModuleConfigurator().configure()
            self?.router.present(view)
        }
    }

}
