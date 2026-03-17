// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "LibXLS",
    platforms: [
        .iOS(.v18),
    ],
    products: [
        .library(
            name: "LibXLS",
            targets: ["LibXLS"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "libxls",
            path: "build-libxls/libxls.xcframework"
        ),
        .target(
            name: "LibXLS",
            dependencies: ["libxls"],
            linkerSettings: [
                .linkedLibrary("iconv")
            ]
        ),
    ]
)
