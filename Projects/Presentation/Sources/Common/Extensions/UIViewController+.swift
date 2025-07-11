//
//  UIViewController+.swift
//  Presentation
//
//  Created by 최정인 on 7/8/25.
//

import UIKit

extension UIViewController {

    func configureNavigationBar(navigationStyle: NavigationBarStyle) {
        switch navigationStyle {
        case .hidden:
            navigationController?.setNavigationBarHidden(true, animated: false)

        case .withBackButton(let title):
            navigationController?.setNavigationBarHidden(false, animated: false)
            self.title = title
            configureDefaultBackButton()

        case .withPrograssBar(let step, let stepCount):
            navigationController?.setNavigationBarHidden(false, animated: false)
            configureDefaultBackButton()
            configureProgressNavigationBar(step: step, stepCount: stepCount)
    }

    func configureDefaultBackButton() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(popViewController))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }

    private func configureProgressNavigationBar(step: Int, stepCount: Int) {
        self.title = ""
        let progressView = ProgressBarView(step: step, stepCount: stepCount)
        navigationItem.titleView = progressView
    }

    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

enum NavigationBarStyle {
    case hidden
    case withBackButton(title: String)
    case withPrograssBar(step: Int, stepCount: Int)
}
