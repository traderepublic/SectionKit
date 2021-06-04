// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SectionKit",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(name: "SectionKit", targets: ["SectionKit"]),
        .library(name: "DiffingSectionKit", targets: ["DiffingSectionKit"])
    ],
    dependencies: [
        .package(name: "DifferenceKit", url: "https://github.com/ra1028/DifferenceKit.git", from: "1.1.5")
    ],
    targets: [
        .target(name: "SectionKit", path: "SectionKit/Sources"),
        .testTarget(
            name: "SectionKitTests",
            dependencies: ["SectionKit"],
            path: "SectionKit/Tests"
        ),
        .target(
            name: "DiffingSectionKit",
            dependencies: [
                "SectionKit",
                .product(name: "DifferenceKit", package: "DifferenceKit")
            ],
            path: "DiffingSectionKit/Sources"
        ),
        .testTarget(
            name: "DiffingSectionKitTests",
            dependencies: ["DiffingSectionKit"],
            path: "DiffingSectionKit/Tests"
        )
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
