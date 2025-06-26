//
//  BitnagilFont.swift
//  Presentation
//
//  Created by 최정인 on 6/26/25.
//

import UIKit

enum BitnagilFont {
    case headline1
    case headline2

    case title1
    case title2
    case title3

    case subtitle

    case body1SemiBold
    case body1Medium
    case body1Regular

    case body2SemiBold
    case body2Medium
    case body2Long

    case caption1
    case caption2
    case captionUnderline1
    case captionUnderline2

    case button1
    case button2

    var font: UIFont {
        switch self {
        case .headline1: UIFont.font(FontName.pretendardBold, size: 26)
        case .headline2: UIFont.font(FontName.pretendardBold, size: 24)

        case .title1: UIFont.font(FontName.pretendardBold, size: 22)
        case .title2: UIFont.font(FontName.pretendardBold, size: 20)
        case .title3: UIFont.font(FontName.pretendardSemiBold, size: 18)

        case .subtitle: UIFont.font(FontName.pretendardSemiBold, size: 16)

        case .body1SemiBold: UIFont.font(FontName.pretendardSemiBold, size: 16)
        case .body1Medium: UIFont.font(FontName.pretendardMedium, size: 16)
        case .body1Regular: UIFont.font(FontName.pretendardRegular, size: 16)

        case .body2SemiBold: UIFont.font(FontName.pretendardSemiBold, size: 14)
        case .body2Medium: UIFont.font(FontName.pretendardMedium, size: 14)
        case .body2Long: UIFont.font(FontName.pretendardMedium, size: 14)

        case .caption1: UIFont.font(FontName.pretendardMedium, size: 12)
        case .caption2: UIFont.font(FontName.pretendardMedium, size: 10)
        case .captionUnderline1: UIFont.font(FontName.pretendardSemiBold, size: 12)
        case .captionUnderline2: UIFont.font(FontName.pretendardMedium, size: 12)

        case .button1: UIFont.font(FontName.pretendardSemiBold, size: 16)
        case .button2: UIFont.font(FontName.pretendardSemiBold, size: 14)
        }
    }

    var lineHeight: CGFloat {
        switch self {
        case .headline1: 38
        case .headline2: 34

        case .title1: 32
        case .title2: 30
        case .title3: 24

        case .subtitle: 28

        case .body1SemiBold, .body1Medium, .body1Regular: 24

        case .body2SemiBold, .body2Medium: 20
        case .body2Long: 24

        case .caption1, .caption2, .captionUnderline1, .captionUnderline2: 18

        case .button1: 24
        case .button2: 20
        }
    }

    var letterSpacing: CGFloat {
        switch self {
        case .headline1, .headline2, .title1, .body2SemiBold, .body2Medium: -0.5
        default: 0
        }
    }

    func attributedString(text: String?) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = lineHeight
        style.minimumLineHeight = lineHeight

        return NSAttributedString(
            string: text ?? "Loading···",
            attributes: [.font: font,
                         .paragraphStyle: style,
                         .kern: letterSpacing])
    }
}
