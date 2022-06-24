//
//  StringAttributes.swift
//  
//
//  Created by Евгений Васильев on 23.06.2022.
//

import SurfPlaybook

final class StringAttributesCoordinator: PlaybookFlowCoordinator {

    // MARK: - Private Properties

    private let router = MainRouter()

    // MARK: - PlaybookFlowCoordinator

    var id: String {
        return "StringAttributesCoordinator"
    }

    var name: String {
        return "StringAttributesCoordinator"
    }

    var type: FlowCoordinatorType {
        return .coordinator { [weak self] in
            let (view, _) = StringAttributesModuleConfigurator().configure()
            self?.router.present(view)
        }
    }

}
