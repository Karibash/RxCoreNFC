// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "RxCoreNFC",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "RxCoreNFC", targets: ["RxCoreNFC"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.0.0")
    ],
    targets: [
        .target(name: "RxCoreNFC", dependencies: ["RxSwift", "RxCocoa"], path: "Sources"),
        .testTarget(name: "RxCoreNFCTests", dependencies: ["RxCoreNFC"]),
    ],
    swiftLanguageVersions: [.v5]
)
