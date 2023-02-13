// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "notify",
    dependencies: [
        .package(url: "https://github.com/mtynior/ColorizeSwift.git", from: "1.6.0")
    ],
    targets: [
        .executableTarget(
            name: "notify",
            dependencies: ["ColorizeSwift"])
    ]
)
