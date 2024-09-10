//
//  RouteMeasurerCoordinator.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 24.06.2022.
//

import SurfPlaybook

final class RouteMeasurerCoordinator: PlaybookFlowCoordinator {

    // MARK: - Private Properties

    private let router = MainRouter()

    // MARK: - PlaybookFlowCoordinator

    var id: String {
        return "RouteMeasurerCoordinator"
    }

    var name: String {
        return "RouteMeasurerCoordinator"
    }

    var type: FlowCoordinatorType {
        return .coordinator { [weak self] in
            let (view, _) = RouteMeasurerModuleConfigurator().configure()
            self?.router.present(view)
        }
    }

}
