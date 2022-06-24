//
//  WordDeclinationSelectorCoordinator.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 24.06.2022.
//

import SurfPlaybook

final class WordDeclinationSelectorCoordinator: PlaybookFlowCoordinator {

    // MARK: - Private Properties

    private let router = MainRouter()

    // MARK: - PlaybookFlowCoordinator

    var id: String {
        return "WordDeclinationSelectorCoordinator"
    }

    var name: String {
        return "WordDeclinationSelectorCoordinator"
    }

    var type: FlowCoordinatorType {
        return .coordinator { [weak self] in
            let (view, _) = WordDeclinationSelectorModuleConfigurator().configure()
            self?.router.present(view)
        }
    }

}
