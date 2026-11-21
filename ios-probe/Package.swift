// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CallerIndexContract",
    platforms: [.macOS(.v13), .iOS("18.0")],
    products: [
        .library(name: "CallerIndexContract", targets: ["CallerIndexContract"])
    ],
    targets: [
        .target(name: "CallerIndexContract", path: "SharedIndex"),
        .testTarget(name: "CallerIndexContractTests", dependencies: ["CallerIndexContract"], path: "IndexTests")
    ]
)
