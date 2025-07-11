//
//  EmotionOrbView.swift
//  Presentation
//
//  Created by 반성준 on 7/3/25.
//

import UIKit
import SnapKit
import Then

public class EmotionOrbView: UIView {
    
    // MARK: - Properties
    
    public var emotionType: EmotionType = .happy
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configureLayout() {
        // 감정구슬은 현재 미정이므로 투명 처리
        backgroundColor = .clear
    }
    
    // MARK: - Public Methods
    
    public func animateOrb() {
        // 애니메이션 기능은 추후 구현
    }
}

