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
    @IBOutlet var lineView: [UIView]!
    @IBOutlet var usernameFloatingLabel: UILabel!
    @IBOutlet var passwordFloatingLabel: UILabel!

    private let viewModel: LoginViewModel = .init()
}

// MARK: - LifeCycle

extension LoginViewController: LifeCycle {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.applyThemes()
    }
}

// MARK: - Themes

extension LoginViewController: Themes {
    private func applyThemes() {
        self.usernameTextField.setupTextField(placeholder: Constants.Text.username,
                                              textColor: UIColor.white,
                                              borderStyle: .none,
                                              cornerRadius: .none,
                                              contentType: .username)
        self.passwordTextField.setupTextField(placeholder: Constants.Text.password,
                                              textColor: UIColor.white,
                                              borderStyle: .none,
                                              cornerRadius: .none,
                                              contentType: .username)
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.usernameFloatingLabel.setupLabel(text: Constants.Text.username,
                                              textColor: UIColor.white,
                                              font: UIFont.systemFont(ofSize: 15),
                                              cornerRadius: .none)
        self.passwordFloatingLabel.setupLabel(text: Constants.Text.password,
                                              textColor: UIColor.white,
                                              font: UIFont.systemFont(ofSize: 15),
                                              cornerRadius: .none)
        self.lineView.forEach { view in
            view.setupLineView()
        }
        self.usernameFloatingLabel.isHidden = true
        self.passwordFloatingLabel.isHidden = true
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

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.usernameTextField {
            self.usernameFloatingLabel.showHideWithAnimation(isShow: true)
        } else if textField == self.passwordTextField {
            self.passwordFloatingLabel.showHideWithAnimation(isShow: true)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.usernameTextField {
            if self.usernameTextField.text?.count ?? 0 > 0 {
                self.usernameFloatingLabel.showHideWithAnimation(isShow: true)
            } else {
                self.usernameFloatingLabel.showHideWithAnimation(isShow: false)
            }
        } else if textField == self.passwordTextField {
            if self.passwordTextField.text?.count ?? 0 > 0 {
                self.passwordFloatingLabel.showHideWithAnimation(isShow: true)
            } else {
                self.passwordFloatingLabel.showHideWithAnimation(isShow: false)
            }
        }
    }
}
