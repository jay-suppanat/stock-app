//
//  AppCaller.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import UIKit

// MARK: LifeCycle

class AppCaller: LifeCycle {
    init() {
        self.window = UIApplication.shared
    }

    private var window: UIApplication
}

// MARK: AlertPresentation

extension AppCaller: AlertPresentation {
    //MARK: Internal

    private func alertPresenter(title: String, message: String, actions: [UIAlertAction]) {
        let alert: UIAlertController = UIAlertController(title: title,
                                                         message: message,
                                                         preferredStyle: .alert)

        switch actions.count {
        case 1, 2:
            actions.forEach {
                alert.addAction($0)
            }
        default:
            break
        }

        self.window.getTopViewController()?.present(alert, animated: true)
    }

    private func sheetPresenter(title: String, message: String, actions: [UIAlertAction]) {
        let alert: UIAlertController = UIAlertController(title: title,
                                                         message: message,
                                                         preferredStyle: .actionSheet)
    }

    // MARK: - External

    public func showAlertMessage(message: String) {
        let okButton = UIAlertAction(title: Constants.Button.ok,
                                     style: .default)

        self.alertPresenter(title: Constants.Alert.authorizationFail,
                            message: message,
                            actions: [okButton])
    }
}

// MARK: ControllerPresentation

extension AppCaller: ControllerPresentation {
    // MARK: External

    public func selectedTabBar(selected: SelectedTabBar) {
        guard let tabBar: UITabBarController = self.window.getTabBarViewController() else {
            return
        }

        tabBar.selectedIndex = selected.rawValue
    }

    public func openViewController(menu: OpenController) {
        switch menu {
        case .loginVC:
            let vc = UINavigationController(rootViewController: LoginViewController(viewModel: .init()))
            vc.modalPresentationStyle = .fullScreen
            self.window.getTabBarViewController()?.present(vc, animated: true)
        case .registerVC:
            let vc = RegisterViewController(viewModel: .init())
            self.window.getTopViewController()?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
