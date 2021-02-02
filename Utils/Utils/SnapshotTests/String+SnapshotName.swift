//
//  String+SnapshotName.swift
//  SnapshotTests
//

import UIKit

//swiftlint:disable all
public extension String {
    /// Формирует название снапшота для файловой системы в формате **имя_теста-имя_девайса_версия_айос**
    var snapshotName: String {
        return self + UIDevice.current.snapshotName
    }
}
//swiftlint:enable all
