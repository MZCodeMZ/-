// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "KigoParent",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .executable(
            name: "KigoParentApp",
            targets: ["KigoParentApp"]
        )
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "KigoParentApp",
            dependencies: [],
            path: "Sources/KigoParentApp"
        )
    ]
)
