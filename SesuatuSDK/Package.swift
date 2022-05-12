// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SesuatuSDK",
    platforms: [
            .iOS(.v13),
        ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SesuatuSDK",
            targets: ["SesuatuSDK"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/RxSwiftCommunity/RxAlamofire.git",
                 .branch("main")),
        .package(url: "https://github.com/uber/needle.git", .exact("0.17.2")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .exact( "5.6.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SesuatuSDK",
            dependencies: [
                .product(name: "NeedleFoundation", package: "needle"),
                "RxAlamofire", "SnapKit"
            ]),
        .testTarget(
            name: "SesuatuSDKTests",
            dependencies: ["SesuatuSDK"]),
    ]
)
