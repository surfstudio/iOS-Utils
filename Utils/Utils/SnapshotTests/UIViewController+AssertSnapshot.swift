//
//  UIViewController+AssertSnapshot.swift
//  SnapshotTests
//

import SnapshotTesting

//swiftlint:disable all
public extension UIViewController {
    /// Сравнивает эталон с текущим снапшотом, в случае, если эталона нет записывает новый, если не указан **record**
    /// Обертка для использования библиотеки с UIViewController
    /// - Parameters:
    ///   - drawHierarchyInKeyWindow: если на экране есть cornerRadius не для всех углов должен быть **true**
    ///   - precision: на сколкьо процентов должны совпадать снапшот с эталоном
    ///   - size: если используется экран с UIScrollView нужно указать значение из фигмы
    ///   - traits: использовать если нужны нестандартные трейты
    ///   - named: можно добавить имя теста дополнительно
    ///   - record: **true**, если нужно записать новый эталон, **false** если не нужно записывать, по умолчанию в случае отстуствия эталона работает запись
    ///   - timeout: добавит таймаут
    ///   - file: название файла тестов для директории со снапшотами
    ///   - testName: название теста, лучше не менять
    ///   - line: номер линии
    func assertSnapshot(drawHierarchyInKeyWindow: Bool = true,
                        precision: Float = 1.0,
                        size: CGSize? = nil,
                        traits: UITraitCollection = .init(),
                        named: String? = nil,
                        record: Bool = false,
                        snapshotDirectory: String? = nil,
                        timeout: TimeInterval = 5,
                        file: StaticString = #file,
                        testName: String = #function,
                        line: UInt = #line) {

        DiffSnapshotTesting.assertSnapshot(matching: self,
                                       as: .image(drawHierarchyInKeyWindow: drawHierarchyInKeyWindow,
                                                  precision: precision,
                                                  size: size?.snapshotScrollSize,
                                                  traits: traits),
                                       named: named,
                                       record: record,
                                       timeout: timeout,
                                       file: file,
                                       testName: testName.snapshotName,
                                       line: line)
    }
}
//swiftlint:enable all
