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
        .target(
            name: "SectionKit",
            path: "SectionKit/Sources",
            exclude: [
                "Info.plist"
            ]
        ),
        .testTarget(
            name: "SectionKitTests",
            dependencies: ["SectionKit"],
            path: "SectionKit/Tests",
            exclude: [
                "Info.plist"
            ]
        ),
        .target(
            name: "DiffingSectionKit",
            dependencies: [
                "SectionKit",
                .product(name: "DifferenceKit", package: "DifferenceKit")
            ],
            path: "DiffingSectionKit/Sources",
            exclude: [
                "Info.plist"
            ]
        ),
        .testTarget(
            name: "DiffingSectionKitTests",
            dependencies: ["DiffingSectionKit"],
            path: "DiffingSectionKit/Tests",
            exclude: [
                "Info.plist"
            ]
        )
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
