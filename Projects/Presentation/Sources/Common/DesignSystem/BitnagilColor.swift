//
//  BitnagilColor.swift
//  Presentation
//
//  Created by 최정인 on 6/26/25.
//

import UIKit

enum BitnagilColor {
    private static var bundle: Bundle {
        return Bundle(for: IntroView.self)
    }

    static let kakao = UIColor(named: "Kakao", in: bundle, compatibleWith: nil)

    // MARK: - Gradient
    static let gradientLeft = UIColor(named: "GradientLeft", in: bundle, compatibleWith: nil)
    static let gradientRight = UIColor(named: "GradientRight", in: bundle, compatibleWith: nil)

    // MARK: - Emotion Colors
    static let happy = UIColor(named: "EmotionHappy", in: bundle, compatibleWith: nil)
    static let lethargy = UIColor(named: "EmotionLethargy", in: bundle, compatibleWith: nil)
    static let lonely = UIColor(named: "EmotionLonely", in: bundle, compatibleWith: nil)
    static let sad = UIColor(named: "EmotionSad", in: bundle, compatibleWith: nil)
    static let anxiety = UIColor(named: "EmotionAnxiety", in: bundle, compatibleWith: nil)

    // MARK: - Gray Colors
    static let gray5 = UIColor(named: "Gray5", in: bundle, compatibleWith: nil)
    static let gray7 = UIColor(named: "Gray7", in: bundle, compatibleWith: nil)
    static let gray10 = UIColor(named: "Gray10", in: bundle, compatibleWith: nil)
    static let gray20 = UIColor(named: "Gray20", in: bundle, compatibleWith: nil)
    static let gray30 = UIColor(named: "Gray30", in: bundle, compatibleWith: nil)
    static let gray40 = UIColor(named: "Gray40", in: bundle, compatibleWith: nil)
    static let gray50 = UIColor(named: "Gray50", in: bundle, compatibleWith: nil)
    static let gray60 = UIColor(named: "Gray60", in: bundle, compatibleWith: nil)
    static let gray70 = UIColor(named: "Gray70", in: bundle, compatibleWith: nil)
    static let gray80 = UIColor(named: "Gray80", in: bundle, compatibleWith: nil)
    static let gray90 = UIColor(named: "Gray90", in: bundle, compatibleWith: nil)
    static let gray95 = UIColor(named: "Gray95", in: bundle, compatibleWith: nil)
    static let gray96 = UIColor(named: "Gray96", in: bundle, compatibleWith: nil)
    static let gray97 = UIColor(named: "Gray97", in: bundle, compatibleWith: nil)
    static let gray98 = UIColor(named: "Gray98", in: bundle, compatibleWith: nil)
    static let gray99 = UIColor(named: "Gray99", in: bundle, compatibleWith: nil)

    // MARK: - Navy Colors
    static let navy50 = UIColor(named: "Navy50", in: bundle, compatibleWith: nil)
    static let navy100 = UIColor(named: "Navy100", in: bundle, compatibleWith: nil)
    static let navy200 = UIColor(named: "Navy200", in: bundle, compatibleWith: nil)
    static let navy300 = UIColor(named: "Navy300", in: bundle, compatibleWith: nil)
    static let navy400 = UIColor(named: "Navy400", in: bundle, compatibleWith: nil)
    static let navy500 = UIColor(named: "Navy500", in: bundle, compatibleWith: nil)
    static let navy600 = UIColor(named: "Navy600", in: bundle, compatibleWith: nil)
    static let navy700 = UIColor(named: "Navy700", in: bundle, compatibleWith: nil)
    static let navy800 = UIColor(named: "Navy800", in: bundle, compatibleWith: nil)
    static let navy900 = UIColor(named: "Navy900", in: bundle, compatibleWith: nil)

    // MARK: - LightBlue Colors
    static let lightBlue50 = UIColor(named: "LightBlue50", in: bundle, compatibleWith: nil)
    static let lightBlue75 = UIColor(named: "LightBlue75", in: bundle, compatibleWith: nil)
    static let lightBlue100 = UIColor(named: "LightBlue100", in: bundle, compatibleWith: nil)
    static let lightBlue200 = UIColor(named: "LightBlue200", in: bundle, compatibleWith: nil)
    static let lightBlue300 = UIColor(named: "LightBlue300", in: bundle, compatibleWith: nil)
    static let lightBlue400 = UIColor(named: "LightBlue400", in: bundle, compatibleWith: nil)
    static let lightBlue500 = UIColor(named: "LightBlue500", in: bundle, compatibleWith: nil)
    static let lightBlue600 = UIColor(named: "LightBlue600", in: bundle, compatibleWith: nil)
    static let lightBlue700 = UIColor(named: "LightBlue700", in: bundle, compatibleWith: nil)
    static let lightBlue800 = UIColor(named: "LightBlue800", in: bundle, compatibleWith: nil)
    static let lightBlue900 = UIColor(named: "LightBlue900", in: bundle, compatibleWith: nil)

    // MARK: - White Colors
    static let white50 = UIColor(named: "White50", in: bundle, compatibleWith: nil)
    static let white100 = UIColor(named: "White100", in: bundle, compatibleWith: nil)
    static let white200 = UIColor(named: "White200", in: bundle, compatibleWith: nil)
    static let white300 = UIColor(named: "White300", in: bundle, compatibleWith: nil)
    static let white400 = UIColor(named: "White400", in: bundle, compatibleWith: nil)
    static let white500 = UIColor(named: "White500", in: bundle, compatibleWith: nil)
    static let white600 = UIColor(named: "White600", in: bundle, compatibleWith: nil)
    static let white700 = UIColor(named: "White700", in: bundle, compatibleWith: nil)
    static let white800 = UIColor(named: "White800", in: bundle, compatibleWith: nil)
    static let white900 = UIColor(named: "White900", in: bundle, compatibleWith: nil)
}
