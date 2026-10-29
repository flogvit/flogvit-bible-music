// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "BibleSongs",
    platforms: [.macOS(.v14)],
    targets: [
        .executableTarget(name: "BibleSongs", path: "Sources/BibleSongs")
    ]
)
