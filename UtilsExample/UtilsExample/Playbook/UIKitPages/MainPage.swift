//
//  TestUIKitPage.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 21.06.2022.
//

import UIKit
import SurfPlaybook

final class MainPage: PlaybookUIKitPage {

    var id: String {
        return "MainPage"
    }

    var name: String {
        return "Main page"
    }

    var viewModel: UIKitPageViewModel {
        return TestUIKitPageViewModel()
    }

}

final class TestUIKitPageViewModel: NSObject, UIKitPageViewModel {

    func setup(with tableView: UITableView) {
    }

}

