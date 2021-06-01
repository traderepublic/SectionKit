// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "VanillaSwiftExamples",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "VanillaSwiftExamples", targets: ["VanillaSwiftExamples"])
    ],
    dependencies: [
        .package(name: "SectionKit", path: "../../"),
        .package(name: "Utilities", path: "Utilities")
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
            name: "VanillaSwiftExamplesTests",
            dependencies: [
                "VanillaSwiftExamples",
                .product(name: "TestUtilities", package: "Utilities")
            ]
        )
    ]
)
