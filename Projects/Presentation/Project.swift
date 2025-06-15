import ProjectDescription

let project = Project(
  name: "Presentation",
  targets: [
    .target(
      name: "Presentation",
      destinations: .iOS,
      product: .framework, // dynamicFramework면 .framework로!
      bundleId: "com.bitnagil.presentation",
      deploymentTargets: .iOS("15.0"),
      infoPlist: .default,
      sources: ["Sources/**"],
      resources: [],
      dependencies: [
        .project(target: "Domain", path: "../Domain"),
        .project(target: "Shared", path: "../Shared")
        // SnapKit, Then 추후에
      ]
    )
  ]
)
