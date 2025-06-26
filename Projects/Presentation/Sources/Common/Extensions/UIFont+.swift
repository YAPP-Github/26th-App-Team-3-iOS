//
//  UIFont+.swift
//  Presentation
//
//  Created by 최정인 on 6/26/25.
//

import UIKit

extension UIFont {
    static func font(_ style: FontName, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: style.rawValue, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
}
