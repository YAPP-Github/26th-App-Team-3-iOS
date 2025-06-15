import ProjectDescription

let project = Project(
  name: "App",
  targets: [
    .target(
      name: "App",
      destinations: .iOS,
      product: .app,
      bundleId: "com.bitnagil.app",
      deploymentTargets: .iOS("15.0"),
      infoPlist: .default,
      sources: ["Sources/**"],
      dependencies: [
        .project(target: "Presentation", path: "../Presentation"),
        .project(target: "Domain", path: "../Domain"),
        .project(target: "DataSource", path: "../DataSource"),
        .project(target: "Shared", path: "../Shared")
      ]
    )
  ]
)
