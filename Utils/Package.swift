// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Utils",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "Utils",
            targets: ["Utils"]),
    ],
    dependencies: [
        .package(
            name: "CryptoSwift",
            url: "https://github.com/krzyzanowskim/CryptoSwift",
            .exact("1.3.1")
        ),
        .package(
            name: "Device",
            url: "https://github.com/Alelenka/Device",
            .branch("spm-support")
        ),
    ],
    targets: [
        .target(
            name: "Utils",
            dependencies: ["CryptoSwift", "Device"],
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
