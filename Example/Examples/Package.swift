// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Examples",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "Examples", targets: ["Examples"]),
    ],
    dependencies: [
        .package(name: "SectionKit", path: "../../"),
        .package(name: "VanillaSwiftExamples", path: "VanillaSwiftExamples"),
        .package(name: "ReactiveSwiftExamples", path: "ReactiveSwiftExamples"),
        .package(name: "Utilities", path: "Utilities")
    ],
    targets: [
        .target(
            name: "Examples",
            dependencies: [
                .product(name: "SectionKit", package: "SectionKit"),
                .product(name: "VanillaSwiftExamples", package: "VanillaSwiftExamples"),
                .product(name: "ReactiveSwiftExamples", package: "ReactiveSwiftExamples"),
                .product(name: "Utilities", package: "Utilities")
            ]
        ),
        .testTarget(
            name: "ExamplesTests",
            dependencies: [
                "Examples",
                .product(name: "TestUtilities", package: "Utilities")
            ]
        ),
    ]
)
