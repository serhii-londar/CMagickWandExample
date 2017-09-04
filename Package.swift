// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "MagicWandExample",
    dependencies: [
        .Package(url: "https://github.com/serhii-londar/MagickWand.git", majorVersion: 0)
    ]
)
