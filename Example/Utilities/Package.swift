// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Utilities",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "Utilities", targets: ["Utilities"]),
        .library(name: "TestUtilities", targets: ["TestUtilities"])
    ],
    dependencies: [
        .package(name: "SectionKit", path: "../../"),
        .package(name: "swift-snapshot-testing", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.10.0")
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
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            exclude: ["__Snapshots__"]
        ),
        .target(
            name: "TestUtilities",
            dependencies: [
                .product(name: "SectionKit", package: "SectionKit")
            ]
        )
    ]
)
