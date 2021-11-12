// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DevicePack",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_12)
    ],
    products: [
        .library(
            name: "DevicePack",
            targets: ["DevicePack"])
    ],
    targets: [
        .target(name: "DevicePack")
    ]
)
