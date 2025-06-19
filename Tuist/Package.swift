// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "Bitnagil",
  dependencies: [
    .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.0"),
    .package(url: "https://github.com/devxoul/Then.git", from: "3.0.0") 
  ]
)
