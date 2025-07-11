//
//  OnboardingChoiceType.swift
//  Presentation
//
//  Created by 최정인 on 7/9/25.
//

enum OnboardingChoiceType: CaseIterable, OnboardingChoiceProtocol {
    case morningTime
    case eveningTime
    case allTime

    case never
    case rarely
    case sometimes
    case often

    case stability
    case connection
    case growth
    case vitality

    case once
    case twoToThree
    case fourOrMore
    case notSure

    var onboardingType: OnboardingType {
        switch self {
        case .morningTime: .time
        case .eveningTime: .time
        case .allTime: .time

        case .never: .frequency
        case .rarely: .frequency
        case .sometimes: .frequency
        case .often: .frequency

        case .stability: .feeling
        case .connection: .feeling
        case .growth: .feeling
        case .vitality: .feeling

        case .once: .outdoorGoal
        case .twoToThree: .outdoorGoal
        case .fourOrMore: .outdoorGoal
        case .notSure: .outdoorGoal
        }
    }

    var mainTitle: String {
        switch self {
        case .morningTime: "아침을 잘 시작하고 싶어요."
        case .eveningTime: "저녁을 편안하게 마무리하고 싶어요."
        case .allTime: "언제든 상관 없어요."

        case .never: "밖에 나가지 않고 집에서만 지냈어요."
        case .rarely: "잠깐 외출했어요."
        case .sometimes: "가끔 나가요."
        case .often: "자주 외출해요."

        case .stability: "안정감"
        case .connection: "연결감"
        case .growth: "성장감"
        case .vitality: "생동감"

        case .once: "시작이 더 중요해요."
        case .twoToThree: "너무 무리하지 않아도 괜찮아요."
        case .fourOrMore: "이 정도면 충분히 활력 있는 한 주가 될거에요."
        case .notSure: "목표 선택을 도와드릴게요!"
        }
    }

    var subTitle: String? {
        switch self {
        case .stability:
            return "하루를 편안하게 보내고 싶어요."
        case .connection:
            return "누군가와 함께 있다는 느낌이 필요해요."
        case .growth:
            return "작은 변화라도 시작하고 싶어요."
        case .vitality:
            return "무기력을 이겨내고 활력을 찾고싶어요."

        case .once:
            return "일주일에 1회"
        case .twoToThree:
            return "일주일에 2~3회"
        case .fourOrMore:
            return "일주일에 4회 이상"
        case .notSure:
            return "아직 잘 모르겠어요"

        default:
            return nil
        }
    }

    var resultTitle: String? {
        switch self {
        case .morningTime:
            return "아침루틴"
        case .eveningTime:
            return "저녁루틴"
        case .allTime:
            return "전체루틴"

        case .stability:
            return "안정감"
        case .connection:
            return "연결감"
        case .growth:
            return "성장감"
        case .vitality:
            return "생동감"

        case .once:
            return "주 1회 외출"
        case .twoToThree:
            return "주 3회 외출"
        case .fourOrMore:
            return "주 4회 이상 외출"
        case .notSure:
            return "최소한의 외출"

        default:
            return nil
        }
    }
}
