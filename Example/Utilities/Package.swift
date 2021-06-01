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
    dependencies: [
        .package(name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.9.0")
    ],
    targets: [
        .target(name: "Utilities"),
        .testTarget(
            name: "UtilitiesTests",
            dependencies: [
                "Utilities",
                "TestUtilities"
            ]
        ),
        .testTarget(
            name: "UtilitiesSnapshotTests",
            dependencies: [
                "Utilities",
                "TestUtilities",
                .product(name: "SnapshotTesting", package: "SnapshotTesting")
            ]
        ),
        .target(name: "TestUtilities"),
    ]
)
