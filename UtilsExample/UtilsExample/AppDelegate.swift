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
            .add(chapter: StringAttributesChapter().build())
            .add(chapter: QueryStringBuilderChapter().build())
            .add(chapter: CustomSwitchChapter().build())
            .add(chapter: GeolocationServiceChapter().build())
            .add(chapter: UIDeviceChapter().build())
            .add(uiKitPage: MainPage())
            .start(from: window)

        return true
    }

}
