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
        }
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

    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

enum NavigationBarStyle {
    case hidden
    case withBackButton(title: String)
}
