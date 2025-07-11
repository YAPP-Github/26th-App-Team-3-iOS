//
//  RoutineCardView.swift
//  Presentation
//
//  Created by 반성준 on 7/3/25.
//

import UIKit
import SnapKit
import Then
import Shared

public class RoutineCardView: UIView {
    
    // MARK: - Properties
    
    public var onDetailButtonTapped: (() -> Void)?
    public var onCardTapped: (() -> Void)?
    
    // MARK: - UI Components
    
    private let containerView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 1, alpha: 1) // #F6FAFF
        $0.layer.cornerRadius = 8
    }
    
    private let timeLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Medium", size: 10)
        $0.textColor = UIColor(red: 0.36, green: 0.4, blue: 0.5, alpha: 1) // #5D6680
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        $0.textColor = UIColor(red: 0.09, green: 0.09, blue: 0.1, alpha: 1) // #171719
    }
    
    private let checkboxView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.84, green: 0.91, blue: 1, alpha: 1) // #D7E9FF
        $0.layer.cornerRadius = 4
    }
    
    private let checkImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark")
        $0.tintColor = .white
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    private let moreButton = UIButton().then {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = UIColor(red: 0.05, green: 0.11, blue: 0.25, alpha: 1) // #0D1B41
        $0.transform = CGAffineTransform(rotationAngle: .pi / 2)
    }
    
    private let detailStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 2
        $0.isHidden = true
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
        addSubview(containerView)
        containerView.addSubview(timeLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(checkboxView)
        checkboxView.addSubview(checkImageView)
        containerView.addSubview(moreButton)
        containerView.addSubview(detailStackView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(61)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.leading.equalToSuperview().offset(14)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(14)
        }
        
        checkboxView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(9)
            make.width.height.equalTo(18)
        }
        
        checkImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(14)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
            make.width.height.equalTo(24)
        }
        
        detailStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().inset(14)
            make.bottom.equalToSuperview().inset(9)
        }
    }
    
    private func configureAttribute() {
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(containerTapped))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Public Methods
    
    func configure(with routine: RoutineModel) {
        // 시간 설정
        timeLabel.text = routine.timeRange
        
        // 제목 설정
        titleLabel.text = routine.title
        
        // 완료 상태 설정 (전체 태스크가 완료되었는지 확인)
        let allCompleted = routine.tasks.allSatisfy { $0.isCompleted }
        updateCompletionStatus(allCompleted)
        
        // 세부 루틴 설정
        detailStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        routine.tasks.forEach { task in
            let detailView = createDetailView(task)
            detailStackView.addArrangedSubview(detailView)
        }
    }
    
    private func updateCompletionStatus(_ isCompleted: Bool) {
        if isCompleted {
            checkboxView.backgroundColor = UIColor(red: 0.05, green: 0.11, blue: 0.25, alpha: 1) // #0D1B41
            checkImageView.isHidden = false
        } else {
            checkboxView.backgroundColor = UIColor(red: 0.84, green: 0.91, blue: 1, alpha: 1) // #D7E9FF
            checkImageView.isHidden = true
        }
    }
    
    private func createDetailView(_ task: RoutineTask) -> UIView {
        let container = UIView()
        
        let checkView = UIView().then {
            $0.backgroundColor = task.isCompleted ?
                UIColor(red: 1, green: 0.44, blue: 0.06, alpha: 1) : // #FF6F0F
                UIColor(red: 0.88, green: 0.89, blue: 0.89, alpha: 1) // #E1E2E4
            $0.layer.cornerRadius = 2
        }
        
        let titleLabel = UILabel().then {
            $0.text = task.title
            $0.font = UIFont(name: "Pretendard-Medium", size: 14)
            $0.textColor = UIColor(red: 0.16, green: 0.16, blue: 0.18, alpha: 1) // #292A2D
        }
        
        container.addSubview(checkView)
        container.addSubview(titleLabel)
        
        checkView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.centerY.equalToSuperview()
            make.width.equalTo(14)
            make.height.equalTo(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkView.snp.trailing).offset(11)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        container.snp.makeConstraints { make in
            make.height.equalTo(34)
        }
        
        return container
    }
    
    // MARK: - Actions
    
    @objc private func moreButtonTapped() {
        // 상세 뷰 토글
        let isExpanding = detailStackView.isHidden
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            
            self.detailStackView.isHidden = !isExpanding
            
            if !isExpanding {
                self.containerView.snp.updateConstraints { make in
                    make.height.equalTo(61)
                }
            } else {
                let detailHeight = 34 * self.detailStackView.arrangedSubviews.count + 2 * max(0, self.detailStackView.arrangedSubviews.count - 1)
                self.containerView.snp.updateConstraints { make in
                    make.height.equalTo(61 + 20 + detailHeight + 9)
                }
            }
            
            self.superview?.layoutIfNeeded()
        }
        
        onDetailButtonTapped?()
    }
    
    @objc private func containerTapped() {
        // 전체 영역 탭 시 콜백 호출
        onCardTapped?()
    }
}
