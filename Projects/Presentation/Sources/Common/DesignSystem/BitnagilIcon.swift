//
//  BitnagilIcon.swift
//  Presentation
//
//  Created by 최정인 on 7/6/25.
//

import UIKit

enum BitnagilIcon {
    private static var bundle: Bundle {
        return Bundle(for: IntroView.self)
    }

    static let kakaoIcon = UIImage(named: "kakao_icon", in: bundle, with: nil)
    static let appleIcon = UIImage(named: "apple_icon", in: bundle, with: nil)
    static let checkIcon = UIImage(named: "check_icon", in: bundle, with: nil)?.withRenderingMode(.alwaysTemplate)
}
