//
//  SceneDelegate.swift
//  App
//
//  Created by 최정인 on 6/15/25.
//

import UIKit
import DataSource
import Domain
import Presentation
import NetworkService
import Shared

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    // TODO: DI 수정 필요
    private func dependencyInjection() {
        let networkService = NetworkService()
        DIContainer.shared.register(type: NetworkServiceProtocol.self, instance: networkService)

        let testRepository: TestRepositoryProtocol = TestRepository(networkService: networkService)
        DIContainer.shared.register(type: TestRepositoryProtocol.self, instance: testRepository)

        let testUseCase: TestUseCase = TestUseCase(testRepository: testRepository)
        DIContainer.shared.register(type: TestUseCase.self, instance: testUseCase)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        dependencyInjection()

        let testUseCase = DIContainer.shared.resolve(type: TestUseCase.self)!
        let navigationController = UINavigationController(rootViewController: HomeViewController(usecase: testUseCase))
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
