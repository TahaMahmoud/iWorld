// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(name: "DesignSystem",
                 targets: ["DesignSystem"])
    ],
    dependencies: [
        .package(name: "Core",
                 path: "../Core")
    ],
    targets: [
        .target(name: "DesignSystem",
                dependencies: [
                    .product(name: "Core", package: "Core")
                ],
                resources: [
                    .copy("../DesignSystem/Resources/Icons/Assets.xcassets"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-Black.otf"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-BlackItalic.otf"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-Bold.otf"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-BoldItalic.otf"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-ExtraBold.otf"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-ExtraBoldItalic.otf"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-Light.otf"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-LightItalic.otf"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-Medium.otf"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-MediumItalic.otf"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-Regular.otf"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-SemiBold.otf"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-SemiBoldItalic.otf"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-Thin.otf"),
                    .copy("../DesignSystem/Resources/Fonts/iWorld/Gellix-ThinItalic.otf")]
               ),
        .testTarget(
            name: "DesignSystemTests",
            dependencies: ["DesignSystem"])
    ]
)
