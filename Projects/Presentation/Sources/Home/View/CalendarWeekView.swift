//
//  CalendarWeekView.swift
//  Presentation
//
//  Created by 반성준 on 7/3/25.
//

import UIKit
import SnapKit
import Then

final class CalendarWeekView: UIView {
    
    // MARK: - UI Components
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 21
    }
    
    private var dayViews: [CalendarDayView] = []
    private var currentWeekDates: [Date] = []
    private let calendar = Calendar.current
    
    // MARK: - Properties
    
    private var weekOffset: Int = 0  // 현재 주 오프셋 (0 = 이번 주)
    
    var selectedDate: Date = Date() {
        didSet {
            updateWeek()
        }
    }
    
    var onDateSelected: ((Date) -> Void)?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        updateWeek()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configureLayout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 7개의 DayView 생성
        for _ in 0..<7 {
            let dayView = CalendarDayView()
            dayView.onTap = { [weak self] date in
                self?.selectedDate = date
                self?.onDateSelected?(date)
            }
            dayViews.append(dayView)
            stackView.addArrangedSubview(dayView)
        }
    }
    
    private func updateWeek() {
        // 현재 날짜 기준으로 weekOffset 만큼 이동한 주의 월요일 찾기
        let today = Date()
        guard let weekDate = calendar.date(byAdding: .weekOfYear, value: weekOffset, to: today) else { return }
        
        let weekday = calendar.component(.weekday, from: weekDate)
        let daysFromMonday = (weekday == 1) ? -6 : -(weekday - 2)
        
        guard let monday = calendar.date(byAdding: .day, value: daysFromMonday, to: weekDate) else { return }
        
        // 월요일부터 일요일까지의 날짜 계산
        currentWeekDates = (0..<7).compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: monday)
        }
        
        // 각 DayView 업데이트
        let todayStart = calendar.startOfDay(for: today)
        let selectedDay = calendar.startOfDay(for: selectedDate)
        
        for (index, dayView) in dayViews.enumerated() {
            guard index < currentWeekDates.count else { continue }
            
            let date = currentWeekDates[index]
            let isToday = calendar.isDate(date, inSameDayAs: todayStart)
            let isSelected = calendar.isDate(date, inSameDayAs: selectedDay)
            
            dayView.configure(
                date: date,
                isToday: isToday,
                isSelected: isSelected
            )
        }
    }
    
    // MARK: - Public Methods
    
    func moveToNextWeek() {
        weekOffset += 1
        updateWeek()
    }
    
    func moveToPreviousWeek() {
        weekOffset -= 1
        updateWeek()
    }
    
    func moveToToday() {
        weekOffset = 0
        selectedDate = Date()
        updateWeek()
    }
}

// MARK: - CalendarDayView

private final class CalendarDayView: UIView {
    
    private let weekdayLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Medium", size: 12)
        $0.textAlignment = .center
    }
    
    private let dateButton = UIButton().then {
        $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 14)
        $0.layer.cornerRadius = 8
    }
    
    private var date: Date?
    var onTap: ((Date) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        configureAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        addSubview(weekdayLabel)
        addSubview(dateButton)
        
        weekdayLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(18)
        }
        
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(weekdayLabel.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(29)
        }
    }
    
    private func configureAttribute() {
        dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
    }
    
    func configure(date: Date, isToday: Bool, isSelected: Bool) {
        self.date = date
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        // 요일 표시 (오늘인 경우만 "오늘"로 표시)
        if isToday {
            weekdayLabel.text = "오늘"
        } else {
            dateFormatter.dateFormat = "E"
            weekdayLabel.text = dateFormatter.string(from: date)
        }
        
        // 날짜 표시
        let day = Calendar.current.component(.day, from: date)
        dateButton.setTitle("\(day)", for: .normal)
        
        // 스타일 적용
        if isSelected {
            weekdayLabel.textColor = UIColor(red: 23/255, green: 23/255, blue: 25/255, alpha: 1)
            dateButton.backgroundColor = UIColor(red: 207/255, green: 230/255, blue: 255/255, alpha: 1)
            dateButton.setTitleColor(UIColor(red: 23/255, green: 23/255, blue: 25/255, alpha: 1), for: .normal)
        } else if isToday {
            weekdayLabel.textColor = UIColor(red: 41/255, green: 42/255, blue: 45/255, alpha: 1)
            dateButton.backgroundColor = UIColor(red: 228/255, green: 240/255, blue: 255/255, alpha: 1)
            dateButton.setTitleColor(UIColor(red: 41/255, green: 42/255, blue: 45/255, alpha: 1), for: .normal)
        } else {
            weekdayLabel.textColor = UIColor(red: 152/255, green: 155/255, blue: 162/255, alpha: 1)
            dateButton.backgroundColor = .clear
            dateButton.setTitleColor(UIColor(red: 152/255, green: 155/255, blue: 162/255, alpha: 1), for: .normal)
        }
    }
    
    @objc private func dateButtonTapped() {
        guard let date = date else { return }
        onTap?(date)
    }
}
