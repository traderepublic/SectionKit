// swift-tools-version:5.5

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
        .package(name: "swift-snapshot-testing", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.10.0")
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
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            exclude: ["__Snapshots__"]
        )
    ]
)
