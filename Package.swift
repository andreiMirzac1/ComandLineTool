// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImageTool",
    products: [.executable(name: "ImageTool", targets: ["ImageTool"])],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.1.0")
    ],
    targets: [
        .target(name: "ImageTool",
                dependencies: ["ImageToolCore"]),
        .target(name: "ImageToolCore",
                dependencies: ["ImageLibrary", .product(name: "ArgumentParser", package: "swift-argument-parser")]),
        .testTarget( name: "ImageToolCoreTests",
                     dependencies: ["ImageTool", .product(name: "ArgumentParser", package: "swift-argument-parser")]),
        .target(name: "ImageLibrary", dependencies: []),
        .testTarget(name: "ImageLibraryTests", dependencies: ["ImageLibrary"])
])




