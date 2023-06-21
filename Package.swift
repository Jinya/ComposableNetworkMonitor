// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ComposableNetworkMonitor",
  platforms: [.macOS(.v11), .iOS(.v15), .watchOS(.v8), .tvOS(.v15)],
  products: [
    .library(
      name: "ComposableNetworkMonitor",
      targets: ["ComposableNetworkMonitor"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.5.1"),
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "0.8.0")
  ],
  targets: [
    .target(
      name: "ComposableNetworkMonitor",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay")
      ]
    ),
    .testTarget(
      name: "ComposableNetworkMonitorTests",
      dependencies: ["ComposableNetworkMonitor"]
    ),
  ]
)
