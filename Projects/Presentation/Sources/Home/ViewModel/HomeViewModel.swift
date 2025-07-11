//
//  HomeViewModel.swift
//  Presentation
//
//  Created by 최정인 on 6/26/25.
//

import Foundation
import Combine
import Shared
import Domain

// MARK: - Notification Names
extension Notification.Name {
    static let navigateToNotification = Notification.Name("navigateToNotification")
    static let navigateToEmotionRecord = Notification.Name("navigateToEmotionRecord")
    static let navigateToAddRoutine = Notification.Name("navigateToAddRoutine")
}

public final class HomeViewModel: ViewModel {
    public enum Input {
        case viewDidLoad
        case notificationButtonTapped
        case emotionRecordButtonTapped
        case previousWeekButtonTapped
        case nextWeekButtonTapped
        case floatingButtonTapped
        case dateSelected(Date)
        case refreshData
    }
    
    public struct Output {
        // 빈 Output 구조체 (ViewModel 프로토콜 준수용)
    }
    
    public private(set) var output: Output
    
    // Published Properties
    @Published var routines: [RoutineModel] = []
    @Published var selectedDate: Date = Date()
    @Published var currentMonth: String = ""
    @Published var isLoading: Bool = false
    @Published var emotionState: EmotionState? = nil
    
    // Computed Properties
    var hasRoutines: AnyPublisher<Bool, Never> {
        $routines.map { !$0.isEmpty }.eraseToAnyPublisher()
    }
    
    // Dependencies
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        self.output = Output()
        
        setupBindings()
        updateCurrentMonth()
    }
    
    private func setupBindings() {
        $selectedDate
            .sink { [weak self] date in
                self?.loadRoutines(for: date)
                self?.updateCurrentMonth()
            }
            .store(in: &cancellables)
    }
    
    public func action(input: Input) {
        switch input {
        case .viewDidLoad:
            loadInitialData()
            
        case .notificationButtonTapped:
            // 알림 화면으로 이동
            NotificationCenter.default.post(
                name: .navigateToNotification,
                object: nil
            )
            
        case .emotionRecordButtonTapped:
            // 감정 기록 화면으로 이동
            NotificationCenter.default.post(
                name: .navigateToEmotionRecord,
                object: nil
            )
            
        case .previousWeekButtonTapped:
            moveToPreviousWeek()
            
        case .nextWeekButtonTapped:
            moveToNextWeek()
            
        case .floatingButtonTapped:
            // 루틴 추가 화면으로 이동
            NotificationCenter.default.post(
                name: .navigateToAddRoutine,
                object: nil
            )
            
        case .dateSelected(let date):
            selectedDate = date
            
        case .refreshData:
            loadRoutines(for: selectedDate)
        }
    }
    
    private func loadInitialData() {
        loadRoutines(for: selectedDate)
        loadEmotionState()
    }
    
    private func loadRoutines(for date: Date) {
        isLoading = true
        
        // 더미 데이터 (개발용)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.routines = self?.getDummyRoutines() ?? []
            self?.isLoading = false
        }
    }
    
    private func loadEmotionState() {
        // 더미 데이터
        emotionState = EmotionState(
            type: .happy,
            intensity: 0.8,
            recordedAt: Date()
        )
    }
    
    private func moveToPreviousWeek() {
        if let prevWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedDate) {
            selectedDate = prevWeek
        }
    }
    
    private func moveToNextWeek() {
        if let nextWeek = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: selectedDate) {
            selectedDate = nextWeek
        }
    }
    
    private func updateCurrentMonth() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월"
        currentMonth = formatter.string(from: selectedDate)
    }
    
    private func getDummyRoutines() -> [RoutineModel] {
        // 오늘 날짜에도 루틴을 표시하지 않음
        // 나중에 실제 데이터를 연동할 때 이 메서드를 수정하면 됨
        return []
    }
}
