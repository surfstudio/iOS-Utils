//
//  QueryStringBuilderCoordinator.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 23.06.2022.
//

import SurfPlaybook

final class QueryStringBuilderCoordinator: PlaybookFlowCoordinator {

    // MARK: - Private Properties

    private let router = MainRouter()

    // MARK: - PlaybookFlowCoordinator

    var id: String {
        return "QueryStringBuilderCoordinator"
    }

    var name: String {
        return "QueryStringBuilderCoordinator"
    }

    var type: FlowCoordinatorType {
        return .coordinator { [weak self] in
            let (view, _) = QueryStringBuilderModuleConfigurator().configure()
            self?.router.present(view)
        }
    }

}
