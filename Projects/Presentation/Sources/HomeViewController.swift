//
//  HomeViewController.swift
//  Presentation
//
//  Created by 최정인 on 6/15/25.
//

import UIKit
import Domain
import Shared

public final class HomeViewController: UIViewController {

    private let usecase: TestUseCase

    public init(usecase: TestUseCase) {
        self.usecase = usecase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureAttribute()
        configureLayout()
    }

    private func configureAttribute() {
        view.backgroundColor = .blue
        Task {
            guard let entity = await usecase.healthCheck() else { return }
            BitnagilLogger.log(logType: .debug, message: "\(entity.message)")
        }
    }

    private func configureLayout() {
    }
}
