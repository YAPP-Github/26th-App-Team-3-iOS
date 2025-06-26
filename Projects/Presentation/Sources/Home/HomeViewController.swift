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
    private var cancellables: Set<AnyCancellable>

    private let label = UILabel()

    public override init(viewModel: HomeViewModel) {
        cancellables = []
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureAttribute() {
        view.backgroundColor = .blue

        label.do {
            $0.textColor = BitnagilColor.gray90
            $0.attributedText = BitnagilFont.headline1.attributedString(text: nil)
        }

        viewModel.action(input: .healthCheck)
    }

    override func configureLayout() {
        view.addSubview(label)

        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().inset(20)
            make.trailing.lessThanOrEqualToSuperview().inset(20)
        }
    }

    override func bind() {
        viewModel.output.testEntityPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] entity in
                guard let entity else { return }
                self?.label.text = entity.message
                BitnagilLogger.log(logType: .debug, message: entity.message)
            }
            .store(in: &cancellables)
    }
}
