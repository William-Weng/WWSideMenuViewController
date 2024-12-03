// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWSideMenuViewController",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "WWSideMenuViewController", targets: ["WWSideMenuViewController"]),
    ],
    targets: [
        .target(name: "WWSideMenuViewController", resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
