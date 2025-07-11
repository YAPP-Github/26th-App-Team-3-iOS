//
//  TabBarView.swift
//  Presentation
//
//  Created by 반성준 on 7/3/25.
//

import UIKit
import SnapKit
import Then

public protocol TabBarViewDelegate: AnyObject {
    func tabBarView(_ tabBarView: TabBarView, didSelectTab tab: TabBarView.Tab)
}

public class TabBarView: UIView {
    
    // MARK: - Tab
    
    public enum Tab: Int, CaseIterable {
        case home = 0
        case recommendedRoutine
        case report
        case myPage
        
        var title: String {
            switch self {
            case .home:
                return "홈"
            case .recommendedRoutine:
                return "추천 루틴"
            case .report:
                return "리포트"
            case .myPage:
                return "마이페이지"
            }
        }
        
        var iconName: String {
            switch self {
            case .home:
                return "house.fill"
            case .recommendedRoutine:
                return "magnifyingglass.circle"
            case .report:
                return "doc.text"
            case .myPage:
                return "person.crop.circle"
            }
        }
    }
    
    // MARK: - Properties
    
    public weak var delegate: TabBarViewDelegate?
    
    public var selectedTab: Tab = .home {
        didSet {
            updateTabSelection()
        }
    }
    
    private var tabButtons: [TabButton] = []
    
    // MARK: - UI Components
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 0
    }
    
    private let homeIndicatorView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.09, green: 0.09, blue: 0.1, alpha: 1) // #171719
        $0.layer.cornerRadius = 2.5
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        setupTabs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configureLayout() {
        backgroundColor = .white
        
        addSubview(containerView)
        containerView.addSubview(stackView)
        containerView.addSubview(homeIndicatorView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        homeIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
            make.width.equalTo(134)
            make.height.equalTo(5)
        }
    }
    
    private func setupTabs() {
        Tab.allCases.forEach { tab in
            let tabButton = TabButton(tab: tab)
            tabButton.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
            tabButtons.append(tabButton)
            stackView.addArrangedSubview(tabButton)
        }
        
        updateTabSelection()
    }
    
    private func updateTabSelection() {
        tabButtons.forEach { button in
            button.isSelected = button.tab == selectedTab
        }
    }
    
    // MARK: - Actions
    
    @objc private func tabButtonTapped(_ sender: TabButton) {
        selectedTab = sender.tab
        delegate?.tabBarView(self, didSelectTab: sender.tab)
    }
}

// MARK: - TabButton

private class TabButton: UIButton {
    
    // MARK: - Properties
    
    let tab: TabBarView.Tab
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - UI Components
    
    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let tabtitleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Medium", size: 10)
        $0.textAlignment = .center
    }
    
    // MARK: - Initialization
    
    init(tab: TabBarView.Tab) {
        self.tab = tab
        super.init(frame: .zero)
        configureLayout()
        configureAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configureLayout() {
        addSubview(iconImageView)
        addSubview(tabtitleLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        tabtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(-1)
            make.centerX.equalToSuperview()
            make.height.equalTo(16)
        }
    }
    
    private func configureAttribute() {
        tabtitleLabel.text = tab.title
        iconImageView.image = UIImage(systemName: tab.iconName)
        updateAppearance()
    }
    
    private func updateAppearance() {
        if isSelected {
            iconImageView.tintColor = UIColor(red: 0.05, green: 0.11, blue: 0.25, alpha: 1) // #0D1B41
            tabtitleLabel.textColor = UIColor(red: 0.05, green: 0.1, blue: 0.23, alpha: 1) // #0C193B
        } else {
            iconImageView.tintColor = UIColor(red: 0.71, green: 0.72, blue: 0.77, alpha: 1) // #B4B8C4
            tabtitleLabel.textColor = UIColor(red: 0.71, green: 0.72, blue: 0.77, alpha: 1) // #B4B8C4
        }
    }
}
