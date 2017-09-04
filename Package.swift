// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "MagicWandExample",
    dependencies: [
        .Package(url: "../MagickWand", majorVersion: 0)
    ]
)
