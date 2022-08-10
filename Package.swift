// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ConnectivityFramework",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ConnectivityFramework",
            targets: ["ConnectivityFramework"]),
    ],
    dependencies: [
//        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", from: "8.0"),
    ],
    targets: [
        .target(
            name: "ConnectivityFramework",
            dependencies: [
//                .product(name: "FirebaseAuth", package: "Firebase"),
            ])
    ]
)
