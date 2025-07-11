//
//  SceneDelegate.swift
//  App
//
//  Created by 최정인 on 6/15/25.
//

import UIKit
import KakaoSDKAuth
import Presentation
import Shared

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        DIContainer.shared.dependencyInjection()

        // ⚠️ 개발용 임시 설정 - 바로 홈 화면으로 이동
        // TODO: 개발 완료 후 아래 주석 해제하고 홈 화면 코드 삭제
        
        // 임시로 사용자 이름 설정
        UserDefaults.standard.set("테스트", forKey: "userName")
        
        // 홈 화면으로 바로 이동 (개발용)
        let homeViewModel = HomeViewModel()
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        // 원래 코드 (개발 완료 후 주석 해제)
        // let introView = IntroView()
        // let navigationController = UINavigationController(rootViewController: introView)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.window = window
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
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
