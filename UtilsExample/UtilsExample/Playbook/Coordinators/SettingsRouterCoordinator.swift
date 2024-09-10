//
//  SettingsRouterCoordinator.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 24.06.2022.
//

import SurfPlaybook

final class SettingsRouterCoordinator: PlaybookFlowCoordinator {

    // MARK: - Private Properties

    private let router = MainRouter()

    // MARK: - PlaybookFlowCoordinator

    var id: String {
        return "SettingsRouterCoordinator"
    }

    var name: String {
        return "SettingsRouterCoordinator"
    }

    var type: FlowCoordinatorType {
        return .coordinator { [weak self] in
            let (view, _) = SettingsRouterModuleConfigurator().configure()
            self?.router.present(view)
        }
    }

}
