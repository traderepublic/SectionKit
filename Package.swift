// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SectionKit",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SectionKit",
            targets: ["SectionKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ra1028/DifferenceKit", from: "1.1.5"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SectionKit",
            dependencies: ["DifferenceKit"]),
        .testTarget(
            name: "SectionKitTests",
            dependencies: ["SectionKit"]),
    ]
)
