//
//  ProfileViewController.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBAction func openLoginButton(_ sender: Any) {
        AppCaller().openViewController(menu: .loginVC)
    }
}
