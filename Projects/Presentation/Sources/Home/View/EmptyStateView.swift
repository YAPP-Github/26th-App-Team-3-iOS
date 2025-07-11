//
//  EmptyStateView.swift
//  Presentation
//
//  Created by 반성준 on 7/3/25.
//

import UIKit
import SnapKit
import Then

final class EmptyStateView: UIView {
    
    // MARK: - Properties
    
    var onRegisterButtonTapped: (() -> Void)?
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "등록한 루틴이 없어요"
        $0.font = BitnagilFont(style: .subtitle1, weight: .bold).font
        $0.textColor = BitnagilColor.gray30
        $0.textAlignment = .center
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "루틴을 등록해서 빛나길을 시작해보세요"
        $0.font = BitnagilFont(style: .body2, weight: .medium).font
        $0.textColor = BitnagilColor.gray70
        $0.textAlignment = .center
    }
    
    private let registerButton = UIButton().then {
        $0.backgroundColor = BitnagilColor.navy50
        $0.layer.cornerRadius = 17
        
        // iOS 15.0+ UIButtonConfiguration 사용
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.title = "루틴 등록하기"
            config.baseBackgroundColor = BitnagilColor.navy50
            config.baseForegroundColor = BitnagilColor.gray30
            config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10)
            config.background.cornerRadius = 17
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = BitnagilFont(style: .caption1, weight: .medium).font
                return outgoing
            }
            $0.configuration = config
        } else {
            // iOS 15.0 미만 지원
            $0.setTitle("루틴 등록하기", for: .normal)
            $0.setTitleColor(BitnagilColor.gray30, for: .normal)
            $0.titleLabel?.font = BitnagilFont(style: .caption1, weight: .medium).font
            $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        configureAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configureLayout() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(registerButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(34) // 높이 명시
        }
    }
    
    private func configureAttribute() {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func registerButtonTapped() {
        onRegisterButtonTapped?()
    }
}
