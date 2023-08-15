//
//  ItemsScrollManagerCoordinator.swift
//  UtilsExample
//
//  Created by Дмитрий Демьянов on 14.08.2023.
//

import SurfPlaybook

final class ItemsScrollManagerCoordinator: PlaybookFlowCoordinator {

    // MARK: - Private Properties

    private let router = MainRouter()

    // MARK: - PlaybookFlowCoordinator

    var id: String {
        return "ItemsScrollManagerCoordinator"
    }

    var name: String {
        return "ItemsScrollManager & BeanPageControl"
    }

    var type: FlowCoordinatorType {
        return .coordinator { [weak self] in
            let view = ItemsScrollManagerConfigurator().configure()
            self?.router.present(view)
        }
    }

}
