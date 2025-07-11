//
//  HomeViewController.swift
//  Presentation
//
//  Created by 최정인 on 6/15/25.
//

import Foundation
import Combine
import UIKit
import SnapKit
import Then
import Shared

public final class HomeViewController: BaseViewController<HomeViewModel> {
    
    // MARK: - UI Components
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = .clear
        $0.refreshControl = UIRefreshControl()
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let gradientBackgroundView = UIView()
    
    private let greetingLabel = UILabel().then {
        $0.font = BitnagilFont(style: .title1, weight: .semiBold).font
        $0.textColor = BitnagilColor.gray10
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
    }
    
    private let notificationButton = UIButton().then {
        $0.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        $0.tintColor = BitnagilColor.gray10
    }
    
    private let notificationBadge = UIView().then {
        $0.backgroundColor = UIColor(red: 1, green: 0.41, blue: 0.41, alpha: 1) // #FF6868
        $0.layer.cornerRadius = 3
        $0.isHidden = false // 알림이 있으면 표시
    }
    
    private let emotionOrbView = EmotionOrbView()
    
    private let emotionRecordButton = UIButton().then {
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.title = "감정구슬 기록하기"
            config.image = UIImage(systemName: "chevron.right")
            config.baseForegroundColor = BitnagilColor.navy300
            config.imagePlacement = .trailing
            config.imagePadding = 4
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = BitnagilFont(style: .caption1, weight: .medium).font
                return outgoing
            }
            $0.configuration = config
        } else {
            $0.setTitle("감정구슬 기록하기", for: .normal)
            $0.setTitleColor(BitnagilColor.navy300, for: .normal)
            $0.titleLabel?.font = BitnagilFont(style: .caption1, weight: .medium).font
            $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            $0.tintColor = BitnagilColor.navy300
            $0.semanticContentAttribute = .forceRightToLeft
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: -4)
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        }
    }
    
    private let infoButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 8.28
        $0.layer.borderWidth = 1.27
        $0.layer.borderColor = BitnagilColor.gray70?.cgColor
        $0.setTitle("i", for: .normal)
        $0.setTitleColor(BitnagilColor.gray70, for: .normal)
        $0.titleLabel?.font = BitnagilFont(style: .caption1, weight: .semiBold).font
    }
    
    private let whiteContainerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private let monthLabel = UILabel().then {
        $0.font = BitnagilFont(style: .title3, weight: .semiBold).font
        $0.textColor = BitnagilColor.gray10
    }
    
    private let previousWeekButton = UIButton().then {
        $0.setImage(BitnagilIcon.chevronLeft, for: .normal)
        $0.tintColor = BitnagilColor.gray10
    }
    
    private let nextWeekButton = UIButton().then {
        $0.setImage(BitnagilIcon.chevronRight, for: .normal)
        $0.tintColor = BitnagilColor.gray10
    }
    
    private let calendarWeekView = CalendarWeekView()
    
    private let emptyStateView = EmptyStateView()
    
    private let routineStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
    }
    
    private let floatingButton = UIButton().then {
        $0.backgroundColor = BitnagilColor.navy500
        $0.layer.cornerRadius = 26
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = BitnagilColor.gray98
        
        // 그림자 효과
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 8
    }
    
    private let tabBarView = TabBarView()
    
    private let loadingIndicator = UIActivityIndicatorView(style: .medium).then {
        $0.hidesWhenStopped = true
    }
    
    // 플러스 버튼 팝업 메뉴
    private let dimView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        $0.isHidden = true
    }
    
    private let popupMenuView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.isHidden = true
    }
    
    private let reportButton = UIButton().then {
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.title = "제보하기"
            config.baseForegroundColor = BitnagilColor.gray10
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 0)
            config.titleAlignment = .leading
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont(name: "Pretendard-Medium", size: 16)
                return outgoing
            }
            $0.configuration = config
        } else {
            $0.setTitle("제보하기", for: .normal)
            $0.setTitleColor(BitnagilColor.gray10, for: .normal)
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        }
    }
    
    private let reportIconView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.76, green: 0.77, blue: 0.78, alpha: 1) // #C2C4C8
        $0.layer.cornerRadius = 11
    }
    
    private let routineRegisterButton = UIButton().then {
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.title = "루틴 등록"
            config.baseForegroundColor = BitnagilColor.gray10
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 0)
            config.titleAlignment = .leading
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont(name: "Pretendard-Medium", size: 16)
                return outgoing
            }
            $0.configuration = config
        } else {
            $0.setTitle("루틴 등록", for: .normal)
            $0.setTitleColor(BitnagilColor.gray10, for: .normal)
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        }
    }
    
    private let routineIconView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.76, green: 0.77, blue: 0.78, alpha: 1) // #C2C4C8
        $0.layer.cornerRadius = 11
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    // Public init 추가 - App 모듈에서 접근 가능하도록
    public override init(viewModel: HomeViewModel) {
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureAttribute()
        bind()
        viewModel.action(input: .viewDidLoad)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        updateGreeting() // 사용자 이름 업데이트
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupGradientBackground()
    }
    
    // MARK: - Configuration
    
    override func configureLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(gradientBackgroundView)
        contentView.addSubview(greetingLabel)
        contentView.addSubview(notificationButton)
        notificationButton.addSubview(notificationBadge)
        contentView.addSubview(emotionOrbView)
        contentView.addSubview(emotionRecordButton)
        contentView.addSubview(infoButton)
        contentView.addSubview(whiteContainerView)
        
        whiteContainerView.addSubview(monthLabel)
        whiteContainerView.addSubview(previousWeekButton)
        whiteContainerView.addSubview(nextWeekButton)
        whiteContainerView.addSubview(calendarWeekView)
        whiteContainerView.addSubview(emptyStateView)
        whiteContainerView.addSubview(routineStackView)
        whiteContainerView.addSubview(loadingIndicator)
        
        view.addSubview(tabBarView)
        view.addSubview(floatingButton)
        
        // 팝업 메뉴 추가
        view.addSubview(dimView)
        view.addSubview(popupMenuView)
        popupMenuView.addSubview(reportIconView)
        popupMenuView.addSubview(reportButton)
        popupMenuView.addSubview(routineIconView)
        popupMenuView.addSubview(routineRegisterButton)
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tabBarView.snp.top)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        gradientBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(268)
        }
        
        greetingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(85)
            make.leading.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualTo(infoButton.snp.leading).offset(-8)
        }
        
        notificationButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.trailing.equalToSuperview().inset(24)
            make.width.height.equalTo(24)
        }
        
        notificationBadge.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.height.equalTo(6)
        }
        
        emotionOrbView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(107)
            make.trailing.equalToSuperview().inset(54)
            make.width.height.equalTo(101.06)
        }
        
        emotionRecordButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(163)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        infoButton.snp.makeConstraints { make in
            make.leading.equalTo(greetingLabel.snp.trailing).offset(4)
            make.bottom.equalTo(greetingLabel.snp.bottom)
            make.width.height.equalTo(16)
        }
        
        whiteContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(268)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(544)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(20)
        }
        
        previousWeekButton.snp.makeConstraints { make in
            make.centerY.equalTo(monthLabel)
            make.trailing.equalTo(nextWeekButton.snp.leading).offset(-23)
            make.width.height.equalTo(20)
        }
        
        nextWeekButton.snp.makeConstraints { make in
            make.centerY.equalTo(monthLabel)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(20)
        }
        
        calendarWeekView.snp.makeConstraints { make in
            make.top.equalTo(monthLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(54)
        }
        
        emptyStateView.snp.makeConstraints { make in
            make.top.equalTo(calendarWeekView.snp.bottom).offset(97)
            make.centerX.equalToSuperview()
        }
        
        routineStackView.snp.makeConstraints { make in
            make.top.equalTo(calendarWeekView.snp.bottom).offset(23)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(100)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tabBarView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(96)
        }
        
        floatingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(tabBarView.snp.top).offset(-15)
            make.width.height.equalTo(52)
        }
        
        // 팝업 메뉴 레이아웃
        dimView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        popupMenuView.snp.makeConstraints { make in
            make.width.equalTo(143)
            make.height.equalTo(110)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(floatingButton.snp.top).offset(-10)
        }
        
        reportIconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(19)
            make.width.height.equalTo(22)
        }
        
        reportButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalTo(reportIconView)
            make.height.equalTo(44)
        }
        
        routineIconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(68)
            make.width.height.equalTo(22)
        }
        
        routineRegisterButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalTo(routineIconView)
            make.height.equalTo(44)
        }
    }
    
    override func configureAttribute() {
        view.backgroundColor = .white
        
        // 사용자 이름 설정
        updateGreeting()
        
        // 액션 설정
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        emotionRecordButton.addTarget(self, action: #selector(emotionRecordButtonTapped), for: .touchUpInside)
        previousWeekButton.addTarget(self, action: #selector(previousWeekButtonTapped), for: .touchUpInside)
        nextWeekButton.addTarget(self, action: #selector(nextWeekButtonTapped), for: .touchUpInside)
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        
        // Pull to refresh
        scrollView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        // 캘린더 델리게이트
        calendarWeekView.onDateSelected = { [weak self] date in
            self?.viewModel.action(input: .dateSelected(date))
        }
        
        // 탭바 델리게이트
        tabBarView.delegate = self
        
        // 빈 상태 뷰 버튼 액션
        emptyStateView.onRegisterButtonTapped = { [weak self] in
            self?.viewModel.action(input: .floatingButtonTapped)
        }
        
        // 팝업 메뉴 액션
        let dimTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopupMenu))
        dimView.addGestureRecognizer(dimTapGesture)
        
        reportButton.addTarget(self, action: #selector(reportButtonTapped), for: .touchUpInside)
        routineRegisterButton.addTarget(self, action: #selector(routineRegisterButtonTapped), for: .touchUpInside)
    }
    
    private func setupGradientBackground() {
        gradientBackgroundView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let gradientLayer = CAGradientLayer()
        // 디자인 스펙에 맞는 그라데이션 색상 (사용자가 제공한 색상)
        gradientLayer.colors = [
            UIColor(red: 1, green: 0.918, blue: 0.875, alpha: 1).cgColor,    // #FFEADF
            UIColor(red: 0.941, green: 0.969, blue: 1, alpha: 1).cgColor      // #F0F7FF
        ]
        gradientLayer.locations = [0.15, 0.7]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(
            CGAffineTransform(a: 0.79, b: 0.63, c: -2.95, d: 0.79, tx: 1.47, ty: -0.43)
        )
        gradientLayer.bounds = gradientBackgroundView.bounds.insetBy(
            dx: -0.5 * gradientBackgroundView.bounds.size.width,
            dy: -0.5 * gradientBackgroundView.bounds.size.height
        )
        gradientLayer.position = gradientBackgroundView.center
        gradientBackgroundView.layer.addSublayer(gradientLayer)
    }
    
    private func updateGreeting() {
        let userName = UserDefaults.standard.string(forKey: "userName") ?? "사용자"
        greetingLabel.text = "\(userName)님,\n오늘 기분 어때요?"
    }
    
    // MARK: - Binding
    
    override func bind() {
        // 루틴 목록
        viewModel.$routines
            .receive(on: DispatchQueue.main)
            .sink { [weak self] routines in
                self?.updateRoutineList(routines)
            }
            .store(in: &cancellables)
        
        // 루틴 유무
        viewModel.hasRoutines
            .receive(on: DispatchQueue.main)
            .sink { [weak self] hasRoutines in
                self?.emptyStateView.isHidden = hasRoutines
                self?.routineStackView.isHidden = !hasRoutines
            }
            .store(in: &cancellables)
        
        // 현재 월
        viewModel.$currentMonth
            .receive(on: DispatchQueue.main)
            .sink { [weak self] month in
                self?.monthLabel.text = month
            }
            .store(in: &cancellables)
        
        // 로딩 상태
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.loadingIndicator.startAnimating()
                } else {
                    self?.loadingIndicator.stopAnimating()
                    self?.scrollView.refreshControl?.endRefreshing()
                }
            }
            .store(in: &cancellables)
        
        // 감정 상태
        viewModel.$emotionState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] emotionState in
                if let state = emotionState {
                    // 감정 구슬은 현재 미정이므로 타입만 설정
                    self?.emotionOrbView.emotionType = state.type
                }
            }
            .store(in: &cancellables)
        
        // 선택된 날짜
        viewModel.$selectedDate
            .receive(on: DispatchQueue.main)
            .sink { [weak self] date in
                self?.calendarWeekView.selectedDate = date
            }
            .store(in: &cancellables)
    }
    
    private func updateRoutineList(_ routines: [RoutineModel]) {
        routineStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        routines.forEach { routine in
            let routineCard = RoutineCardView()
            routineCard.configure(with: routine)
            routineStackView.addArrangedSubview(routineCard)
        }
    }
    
    // MARK: - Actions
    
    @objc private func notificationButtonTapped() {
        viewModel.action(input: .notificationButtonTapped)
    }
    
    @objc private func emotionRecordButtonTapped() {
        viewModel.action(input: .emotionRecordButtonTapped)
    }
    
    @objc private func previousWeekButtonTapped() {
        viewModel.action(input: .previousWeekButtonTapped)
        calendarWeekView.moveToPreviousWeek()
    }
    
    @objc private func nextWeekButtonTapped() {
        viewModel.action(input: .nextWeekButtonTapped)
        calendarWeekView.moveToNextWeek()
    }
    
    @objc private func floatingButtonTapped() {
        // 팝업 메뉴 표시/숨기기
        let isShowing = !dimView.isHidden
        
        if isShowing {
            // 숨기기
            UIView.animate(withDuration: 0.3, animations: {
                self.dimView.alpha = 0
                self.popupMenuView.alpha = 0
                self.popupMenuView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }) { _ in
                self.dimView.isHidden = true
                self.popupMenuView.isHidden = true
                self.popupMenuView.transform = .identity
            }
        } else {
            // 보이기
            dimView.isHidden = false
            popupMenuView.isHidden = false
            dimView.alpha = 0
            popupMenuView.alpha = 0
            popupMenuView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            UIView.animate(withDuration: 0.3) {
                self.dimView.alpha = 1
                self.popupMenuView.alpha = 1
                self.popupMenuView.transform = .identity
            }
        }
    }
    
    @objc private func dismissPopupMenu() {
        UIView.animate(withDuration: 0.3, animations: {
            self.dimView.alpha = 0
            self.popupMenuView.alpha = 0
            self.popupMenuView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { _ in
            self.dimView.isHidden = true
            self.popupMenuView.isHidden = true
            self.popupMenuView.transform = .identity
        }
    }
    
    @objc private func reportButtonTapped() {
        dismissPopupMenu()
        // 제보하기 기능 구현
        print("제보하기 버튼 탭됨")
    }
    
    @objc private func routineRegisterButtonTapped() {
        dismissPopupMenu()
        viewModel.action(input: .floatingButtonTapped)
    }
    
    @objc private func refreshData() {
        viewModel.action(input: .refreshData)
    }
}

// MARK: - TabBarViewDelegate

extension HomeViewController: TabBarViewDelegate {
    public func tabBarView(_ tabBarView: TabBarView, didSelectTab tab: TabBarView.Tab) {
        switch tab {
        case .home:
            // 이미 홈에 있음
            break
        case .recommendedRoutine:
            // 추천 루틴 화면으로 이동
            NotificationCenter.default.post(name: .navigateToRecommendedRoutine, object: nil)
        case .report:
            // 리포트 화면으로 이동
            NotificationCenter.default.post(name: .navigateToReport, object: nil)
        case .myPage:
            // 마이페이지로 이동
            NotificationCenter.default.post(name: .navigateToMyPage, object: nil)
        }
    }
}

extension Notification.Name {
    static let navigateToRecommendedRoutine = Notification.Name("navigateToRecommendedRoutine")
    static let navigateToReport = Notification.Name("navigateToReport")
    static let navigateToMyPage = Notification.Name("navigateToMyPage")
}
