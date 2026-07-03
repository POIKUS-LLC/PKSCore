// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "PKSCore",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .library(name: "PKSCore", targets: ["PKSCore"]),
        .library(name: "PKSCoreTestSupport", targets: ["PKSCoreTestSupport"]),
    ],
    targets: [
        .target(
            name: "PKSCore",
            swiftSettings: [.swiftLanguageMode(.v6)]
        ),
        .target(
            name: "PKSCoreTestSupport",
            dependencies: ["PKSCore"],
            swiftSettings: [.swiftLanguageMode(.v6)]
        ),
        .testTarget(
            name: "PKSCoreTests",
            dependencies: ["PKSCore", "PKSCoreTestSupport"],
            swiftSettings: [.swiftLanguageMode(.v6)]
        ),
    ]
)
