// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "SkeletonLoad",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "SkeletonLoad",
            targets: ["SkeletonLoad"]),
    ],
    targets: [
        .target(
            name: "SkeletonLoad",
            dependencies: [])
    ]
)
