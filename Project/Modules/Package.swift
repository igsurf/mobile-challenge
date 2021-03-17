// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "CoreArchitecture",
            targets: [
                "CoreArchitecture",
                "CoreInterfaces"
            ]
        ),
    ],

    dependencies: [
        .package(url: "git@github.com:dedeexe/DDXNetwork.git", .exact("1.0.0")),
        .package(name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.8.1")
    ],
    
    targets: [

        // ========================================
        // MODULES
        // ========================================
        .target(
            name: "CoreInterfaces",
            dependencies: [
                "DDXNetwork"
            ]
        ),

        .target(
            name: "CoreArchitecture",
            dependencies: [
                "CoreInterfaces",
                "DDXNetwork"
            ]
        ),

        // ========================================
        // TESTS
        // ========================================

        .testTarget(
            name: "CoreArchitectureTests",
            dependencies: [
                "CoreArchitecture",
                "CoreInterfaces"
            ]
        ),

        .testTarget(
            name: "CoreArchitectureIntegratedTests",
            dependencies: [
                "CoreArchitecture",
                "CoreInterfaces"
            ]
        )
    ]
)

