// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "Auk",
    products: [
        .library(name: "Auk", targets: ["Auk"]),
    ],
    dependencies: [
      .package(
            url: "https://github.com/evgenyneu/moa.git", 
            from: "12.0.0")
    ],
    targets: [
        .target(name: "Auk", dependencies: ["moa"], path: "Auk"),
        .testTarget(
            name: "AukTests",
            dependencies: ["Auk"],
            path: "AukTests"
        )
    ]
)
