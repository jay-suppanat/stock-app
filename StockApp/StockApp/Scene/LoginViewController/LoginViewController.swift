//
//  LoginViewController.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerDescLabel: UILabel!
    @IBOutlet var registerButton: UIButton!

    private let viewModel: LoginViewModel = .init()
}

// MARK: - LifeCycle

extension LoginViewController: LifeCycle {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

// MARK: - UserInterface

extension LoginViewController: UserInterface {
    private func setupUI() {
        self.initLoginButton()
    }

    private func initLoginButton() {
        self.loginButton.addTarget(self, action: #selector(self.touchLoginButton), for: .touchUpInside)
    }
}

// MARK: - Action

extension LoginViewController: Action {
    @objc private func touchLoginButton() {
        self.viewModel.requestLoginService(username: self.usernameTextField.text ?? "", password: self.passwordTextField.text ?? "")
    }
}

// MARK: - Service

extension LoginViewController: Service {
    private func bindViewModel() {
        self.viewModel.loginResponseEvent
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] _ in

                    }
                    .store(in: &self.viewModel.cancellables)
    }
}
