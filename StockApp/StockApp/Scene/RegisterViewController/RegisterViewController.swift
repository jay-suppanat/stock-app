//
//  RegisterViewController.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import UIKit

class RegisterViewController: UIViewController {
    private var viewModel: RegisterViewModel

    required init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: RegisterViewController.identifier, bundle: Bundle(for: RegisterViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle

extension RegisterViewController: LifeCycle {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

