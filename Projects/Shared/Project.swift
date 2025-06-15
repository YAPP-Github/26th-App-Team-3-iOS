import ProjectDescription

let project = Project(
  name: "Shared",
  targets: [
    .target(
      name: "Shared",
      destinations: .iOS,
      product: .staticFramework,
      bundleId: "com.bitnagil.shared",
      deploymentTargets: .iOS("15.0"),
      infoPlist: .default,
      sources: ["Sources/**"],
      dependencies: []
    )
  ]
)
