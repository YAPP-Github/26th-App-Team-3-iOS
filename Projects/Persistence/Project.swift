import ProjectDescription

let project = Project(
    name: "Persistence",
    targets: [
        .target(
            name: "Persistence",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.bitnagil.persistence",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "DataSource", path: "../DataSource"),
                .project(target: "Shared", path: "../Shared")
            ]
        )
    ]
)
