// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "VanillaSwiftExamples",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "VanillaSwiftExamples", targets: ["VanillaSwiftExamples"])
    ],
    dependencies: [
        .package(name: "SectionKit", path: "../../"),
        .package(name: "Utilities", path: "Utilities"),
        .package(name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.9.0")
    ],
    targets: [
        .target(
            name: "VanillaSwiftExamples",
            dependencies: [
                .product(name: "SectionKit", package: "SectionKit"),
                .product(name: "Utilities", package: "Utilities")
            ]
        ),
        .testTarget(
            name: "VanillaSwiftExamplesSnapshotTests",
            dependencies: [
                "VanillaSwiftExamples",
                .product(name: "TestUtilities", package: "Utilities"),
                .product(name: "SnapshotTesting", package: "SnapshotTesting")
            ],
            exclude: ["__Snapshots__"]
        )
    ]
)
