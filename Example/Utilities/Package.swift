// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Utilities",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "Utilities", targets: ["Utilities"]),
        .library(name: "TestUtilities", targets: ["TestUtilities"])
    ],
    targets: [
        .target(name: "Utilities"),
        .testTarget(name: "UtilitiesTests", dependencies: ["Utilities", "TestUtilities"]),
        .target(name: "TestUtilities"),
    ]
)
