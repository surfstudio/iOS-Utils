//
//  KeyboardPresentableCoordinator.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 24.06.2022.
//

import SurfPlaybook

final class KeyboardPresentableCoordinator: PlaybookFlowCoordinator {

    // MARK: - Private Properties

    private let router = MainRouter()

    // MARK: - PlaybookFlowCoordinator

    var id: String {
        return "KeyboardPresentableCoordinator"
    }

    var name: String {
        return "KeyboardPresentableCoordinator"
    }

    var type: FlowCoordinatorType {
        return .coordinator { [weak self] in
            let (view, _) = KeyboardPresentableModuleConfigurator().configure()
            self?.router.present(view)
        }
    }

}
