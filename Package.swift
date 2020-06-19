// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HoleFillingTool",
    products: [
        .executable(name: "HoleFillingTool", targets: ["HoleFillingTool"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "HoleFillingTool",
            dependencies: ["HoleFillingLibrary"]),
        .target(name: "HoleFillingLibrary",  dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")])
])
