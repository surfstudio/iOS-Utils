//
//  GeolocationServiceCoordinator.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 24.06.2022.
//

import SurfPlaybook

final class GeolocationServiceCoordinator: PlaybookFlowCoordinator {

    // MARK: - Private Properties

    private let router = MainRouter()

    // MARK: - PlaybookFlowCoordinator

    var id: String {
        return "GeolocationServiceCoordinator"
    }

    var name: String {
        return "GeolocationServiceCoordinator"
    }

    var type: FlowCoordinatorType {
        return .coordinator { [weak self] in
            let (view, _) = GeolocationServiceModuleConfigurator().configure()
            self?.router.present(view)
        }
    }

}
