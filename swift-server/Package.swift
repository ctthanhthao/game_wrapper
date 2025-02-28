// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "swift-server",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
            ]
        ),
        .executableTarget(
            name: "Run",
            dependencies: [.target(name: "App")]
        )
    ]
)

