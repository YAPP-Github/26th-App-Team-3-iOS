import ProjectDescription

let project = Project(
    name: "App",
    settings: .settings(
        base: ["DEVELOPMENT_TEAM": "5B94TFMJJ4"],
        debug: [:],
        release: [:],
        defaultSettings: .recommended
    ),
    targets: [
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: "com.bitnagil.app",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .file(path: "Resources/Info.plist"),
            sources: ["Sources/**"],
            resources: [
                "Resources/Assets.xcassets",
                "Resources/LaunchScreen.storyboard",
            ],
            dependencies: [
                .project(target: "Presentation", path: "../Presentation"),
                .project(target: "Domain", path: "../Domain"),
                .project(target: "DataSource", path: "../DataSource"),
                .project(target: "Shared", path: "../Shared")
            ]
        )
    ]
)
