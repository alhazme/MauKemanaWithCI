// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Place",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Place",
            targets: ["Place"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", from: "10.1.4"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.0")),
        .package(path: "../Core")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Place",
            dependencies: [
                .product(name: "RealmSwift", package: "Realm"),
                "Core",
                "Alamofire"
            ]),
        .testTarget(
            name: "PlaceTests",
            dependencies: ["Place"]),
    ]
)
