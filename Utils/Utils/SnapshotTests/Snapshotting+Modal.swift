//
//  Snapshotting+Modal.swift
//  Utils
//

import SnapshotTesting

//swiftlint:disable all
extension Snapshotting where Value == UIViewController, Format == UIImage {
    /// Стратегия для  модального представления контроллера
    /// - Parameters:
    ///   - viewController: контроллер, поверх которого будет представлен основной
    ///   - precision: точность
    ///   - size: размер окна
    static func modalImage(viewController: UIViewController, precision: Float, size: CGSize?) -> Snapshotting {
        return Snapshotting<UIImage, UIImage>.image(precision: precision).asyncPullback { vc in
            Async<UIImage> { callback in
                UIView.setAnimationsEnabled(false)

                let window = UIApplication.shared.windows[0]
                window.rootViewController = viewController
                window.frame.size = size!

                viewController.present(vc, animated: false)
                DispatchQueue.main.async {
                    let image = UIGraphicsImageRenderer(bounds: window.bounds).image { ctx in
                        window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
                    }

                    callback(image)
                    UIView.setAnimationsEnabled(true)
                }
             }
        }
    }
}
//swiftlint:enable all
