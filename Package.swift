// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "OneWallpaper",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "OneWallpaper",
            targets: ["OneWallpaper"]),
        .executable(name: "one-wallpaper",
                    targets: ["OneWallpaper"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/chishui/Wallpaper", .branch("main"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "OneWallpaper",
            dependencies: [
              .product(name: "Wallpaper", package: "Wallpaper"), 
              .product(name: "ArgumentParser", package: "swift-argument-parser")  
            ]
        )
    ]
)
