import ProjectDescription

let project = Project(
    name: "DataSource",
    settings: .settings(
        base: [:],
        configurations: [
            .debug(name: "Debug", xcconfig: .relativeToRoot("Projects/DataSource/Resources/Secrets.xcconfig")),
            .release(name: "Release", xcconfig: .relativeToRoot("Projects/DataSource/Resources/Secrets.xcconfig"))
        ],
        defaultSettings: .recommended
    ),
    targets: [
        .target(
            name: "DataSource",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.bitnagil.datasource",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .file(path: "Resources/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/Secrets.xcconfig"],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .project(target: "Shared", path: "../Shared"),
            ]
        )
    ]
)
