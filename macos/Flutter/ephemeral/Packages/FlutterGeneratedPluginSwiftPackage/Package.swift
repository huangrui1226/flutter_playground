// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// Generated file. Do not edit.
//

import PackageDescription

let package = Package(
    name: "FlutterGeneratedPluginSwiftPackage",
    platforms: [
        .macOS("10.15")
    ],
    products: [
        .library(name: "FlutterGeneratedPluginSwiftPackage", type: .static, targets: ["FlutterGeneratedPluginSwiftPackage"])
    ],
    dependencies: [
        .package(name: "flutter_blue_plus_darwin", path: "../.packages/flutter_blue_plus_darwin-7.0.3"),
        .package(name: "connectivity_plus", path: "../.packages/connectivity_plus-7.0.0"),
        .package(name: "app_settings", path: "../.packages/app_settings-7.0.0"),
        .package(name: "FlutterFramework", path: "../.packages/FlutterFramework")
    ],
    targets: [
        .target(
            name: "FlutterGeneratedPluginSwiftPackage",
            dependencies: [
                .product(name: "flutter-blue-plus-darwin", package: "flutter_blue_plus_darwin"),
                .product(name: "connectivity-plus", package: "connectivity_plus"),
                .product(name: "app-settings", package: "app_settings"),
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)
