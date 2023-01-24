// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Utils",
    platforms: [.iOS(.v11), .macOS(.v10_12)],
    products: [
        .library(
            name: "Utils",
            targets: ["Utils"])
    ],
    dependencies: [
        .package(
            name: "CryptoSwift",
            url: "https://github.com/krzyzanowskim/CryptoSwift",
            .exact("1.5.1")
        ),
        .package(
            name: "Autolocalizable",
            url: "https://github.com/surfstudio/Autolocalizable.git",
            from: "1.1.0"
        )
    ],
    targets: [
        .target(
            name: "Utils",
            dependencies: ["CryptoSwift", "Autolocalizable"],
            path: "Utils",
            exclude: [
                "Info.plist"
            ]
        ),
        .testTarget(
            name: "UtilsTests",
            dependencies: ["Utils"],
            path: "UtilsTests",
            exclude: [
                "Info.plist"
            ]
        )
    ]
)
