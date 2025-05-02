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
    @IBOutlet var loginTitleLabel: UILabel!

    private var viewModel: LoginViewModel

    required init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: LoginViewController.identifier, bundle: Bundle(for: LoginViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        self.usernameFloatingLabel.alpha = 0
        self.passwordFloatingLabel.alpha = 0
        self.loginButton.setupButtonTheme(text: Constants.Text.signIn,
                                          textColor: UIColor.tintColor,
                                          backgroundColor: UIColor.white,
                                          cornerRadius: .roundHalf)
        self.loginTitleLabel.setupLabel(text: Constants.Text.signIn,
                                        textColor: UIColor.white,
                                        font: UIFont.systemFont(ofSize: 85),
                                        cornerRadius: .none)
        self.registerDescLabel.setupLabel(text: Constants.Text.registerDesc,
                                          textColor: UIColor.white,
                                          font: UIFont.systemFont(ofSize: 15),
                                          cornerRadius: .none)
        self.registerButton.setupButtonTheme(text: Constants.Text.signUp,
                                             textColor: UIColor.tintColor,
                                             backgroundColor: UIColor.clear,
                                             cornerRadius: .none)
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
            textField.placeholder = ""
        } else if textField == self.passwordTextField {
            self.passwordFloatingLabel.showHideWithAnimation(isShow: true)
            textField.placeholder = ""
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.usernameTextField {
            if self.usernameTextField.text?.count ?? 0 > 0 {
                self.usernameFloatingLabel.showHideWithAnimation(isShow: true)
            } else {
                self.usernameFloatingLabel.showHideWithAnimation(isShow: false)
                self.usernameTextField.placeholder = Constants.Text.username
            }
        } else if textField == self.passwordTextField {
            if self.passwordTextField.text?.count ?? 0 > 0 {
                self.passwordFloatingLabel.showHideWithAnimation(isShow: true)
            } else {
                self.passwordFloatingLabel.showHideWithAnimation(isShow: false)
                self.passwordTextField.placeholder = Constants.Text.password
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.usernameTextField {
            self.usernameTextField.resignFirstResponder()
        } else if textField == self.passwordTextField {
            self.passwordTextField.resignFirstResponder()
        }

        return true
    }
}
