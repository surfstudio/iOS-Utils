//
//  MoneyModelCoordinator.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 24.06.2022.
//

import SurfPlaybook

final class MoneyModelCoordinator: PlaybookFlowCoordinator {

    // MARK: - Private Properties

    private let router = MainRouter()

    // MARK: - PlaybookFlowCoordinator

    var id: String {
        return "MoneyModelCoordinator"
    }

    var name: String {
        return "MoneyModelCoordinator"
    }

    var type: FlowCoordinatorType {
        return .coordinator { [weak self] in
            let (view, _) = MoneyModelModuleConfigurator().configure()
            self?.router.present(view)
        }
    }

}
