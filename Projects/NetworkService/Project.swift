import ProjectDescription

let project = Project(
    name: "NetworkService",
    targets: [
        .target(
            name: "NetworkService",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.bitnagil.networkservice",
            deploymentTargets: .iOS("15.0"),
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
                .project(target: "DataSource", path: "../DataSource"),
                .project(target: "Shared", path: "../Shared")
            ]
        )
    ]
)
