//
//  AppDelegate.swift
//  UtilsExample
//
//  Created by chausov on 09.06.2022.
//

import UIKit
import SurfPlaybook

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    var window: UIWindow?

    // MARK: - UIApplicationDelegate

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()

        Playbook.shared
            .add(flowCoordinator: StringAttributesCoordinator())
            .add(flowCoordinator: CustomSwitchCoordinator())
            .add(flowCoordinator: QueryStringBuilderCoordinator())
            .add(flowCoordinator: UIDeviceCoordinator())
            .add(flowCoordinator: GeolocationServiceCoordinator())
            .add(flowCoordinator: BrightSideCoordinator())
            .add(flowCoordinator: RouteMeasurerCoordinator())
            .add(flowCoordinator: SettingsRouterCoordinator())
            .add(flowCoordinator: WordDeclinationSelectorCoordinator())
            .add(flowCoordinator: KeyboardPresentableCoordinator())
            .add(flowCoordinator: SkeletonViewCoordinator())
            .add(flowCoordinator: MoneyModelCoordinator())
            .add(uiKitPage: MainPage())
            .start(from: window)

        return true
    }

}
