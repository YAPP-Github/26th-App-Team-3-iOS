import ProjectDescription

let project = Project(
    name: "DataSource",
    targets: [
        .target(
            name: "DataSource",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.bitnagil.datasource",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .project(target: "Shared", path: "../Shared"),
            ]
        )
    ]
)
