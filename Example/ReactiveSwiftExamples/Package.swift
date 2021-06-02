// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ReactiveSwiftExamples",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "ReactiveSwiftExamples", targets: ["ReactiveSwiftExamples"])
    ],
    dependencies: [
        .package(name: "SectionKit", path: "../../"),
        .package(name: "Utilities", path: "Utilities"),
        .package(name: "ReactiveCocoa", url: "git@github.com:ReactiveCocoa/ReactiveCocoa.git", from: "11.2.1"),
        .package(name: "ReactiveSwift", url: "git@github.com:ReactiveCocoa/ReactiveSwift.git", from: "6.6.0"),
        .package(name: "SnapshotTesting", url: "git@github.com:pointfreeco/swift-snapshot-testing.git", from: "1.9.0")
    ],
    targets: [
        .target(
            name: "ReactiveSwiftExamples",
            dependencies: [
                .product(name: "SectionKit", package: "SectionKit"),
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "ReactiveCocoa", package: "ReactiveCocoa"),
                .product(name: "ReactiveSwift", package: "ReactiveSwift")
            ]
        ),
        .testTarget(
            name: "ReactiveSwiftExamplesSnapshotTests",
            dependencies: [
                "ReactiveSwiftExamples",
                .product(name: "TestUtilities", package: "Utilities"),
                .product(name: "SnapshotTesting", package: "SnapshotTesting")
            ],
            exclude: ["__Snapshots__"]
        )
    ]
)
