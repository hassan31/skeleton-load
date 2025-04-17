// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Skeleton",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "Skeleton",
            targets: ["SkeletonLoad"]),
    ],
    targets: [
        .target(
            name: "SkeletonLoad",
            dependencies: [])
    ]
)
