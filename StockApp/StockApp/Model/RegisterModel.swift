//
//  RegisterModel.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import Foundation

// MARK: - RegisterModel

struct RegisterModel {
    let username: String
    let password: String
    let confirmPassword: String
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String

    init(username: String, password: String, confirmPassword: String, firstName: String, lastName: String, email: String, phoneNumber: String) {
        self.username = username
        self.password = password
        self.confirmPassword = confirmPassword
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
    }
}
