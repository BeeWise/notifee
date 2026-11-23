// swift-tools-version: 6.0
import PackageDescription

// Resolved through React Native's generated autolinking/libs/RNNotifee location.
let package = Package(
    name: "RNNotifee",
    platforms: [.iOS("15.0")],
    products: [
        .library(name: "RNNotifee", targets: ["RNNotifee"]),
        .library(name: "NotifeeCore", targets: ["NotifeeCore"]),
        .library(name: "RNNotifeeCore", targets: ["RNNotifeeCore"]),
    ],
    dependencies: [
        .package(name: "ReactNative", path: "../../../../xcframeworks"),
    ],
    targets: [
        .target(
            name: "NotifeeCore",
            path: "ios/NotifeeCore",
            publicHeadersPath: ".",
            linkerSettings: [
                .linkedFramework("Foundation"),
                .linkedFramework("UIKit"),
                .linkedFramework("UserNotifications"),
                .linkedFramework("Intents"),
                .linkedFramework("CoreGraphics"),
            ]
        ),
        .target(
            name: "RNNotifeeCore",
            dependencies: ["NotifeeCore"],
            path: "ios/RNNotifee",
            sources: ["NotifeeExtensionHelper.m"],
            publicHeadersPath: "extension-include"
        ),
        .target(
            name: "RNNotifee",
            dependencies: [
                "NotifeeCore",
                .product(name: "ReactHeaders", package: "ReactNative"),
                .product(name: "ReactNativeHeaders", package: "ReactNative"),
                .product(name: "ReactNativeDependenciesHeaders", package: "ReactNative"),
            ],
            path: "ios/RNNotifee",
            sources: ["NotifeeApiModule.m"],
            publicHeadersPath: "include"
        ),
    ],
    cxxLanguageStandard: .cxx20
)
