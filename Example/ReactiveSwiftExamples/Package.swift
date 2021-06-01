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
        .package(name: "ReactiveSwift", url: "git@github.com:ReactiveCocoa/ReactiveSwift.git", from: "6.6.0")
    ],
    targets: [
        .target(
            name: "ReactiveSwiftExamples",
            dependencies: [
                .product(name: "SectionKit", package: "SectionKit"),
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "ReactiveSwift", package: "ReactiveSwift")
            ]
        ),
        .testTarget(name: "ReactiveSwiftExamplesTests", dependencies: ["ReactiveSwiftExamples"])
    ]
)
