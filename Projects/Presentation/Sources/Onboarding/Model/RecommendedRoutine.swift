//
//  RecommendedRoutine.swift
//  Presentation
//
//  Created by 최정인 on 7/11/25.
//

// TODO: 추후 루틴에 대한 값이 명확해진다면 수정할 가능성이 높습니다. (현재는 View만을 위한 모델)
struct RecommendedRoutine: OnboardingChoiceProtocol, Hashable {
    let id: Int
    let mainTitle: String
    let subTitle: String?
}
