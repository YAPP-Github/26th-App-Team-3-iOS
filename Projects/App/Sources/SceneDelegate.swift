//
//  SceneDelegate.swift
//  App
//
//  Created by 최정인 on 6/15/25.
//

import UIKit
import Presentation
import Shared

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        DIContainer.shared.dependencyInjection()
        guard let homeViewModel = DIContainer.shared.resolve(type: HomeViewModel.self) else {
            fatalError("homeViewModel 의존성이 등록되지 않았습니다.")
        }

        let navigationController = UINavigationController(rootViewController: HomeViewController(viewModel: homeViewModel))
        navigationController.isNavigationBarHidden = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}
