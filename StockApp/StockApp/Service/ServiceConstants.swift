//
//  ServiceConstants.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

enum ServiceConstants {
    enum HeaderKey {
        static let contentType = "Content-Type"
    }

    enum HeaderValue {
        static let json = "application/json"
        static let xForm = "application/x-www-form-urlencoded"
        static let pdf = "application/pdf"
    }

    enum ParameterKey {
        static let username = "username"
        static let password = "password"
        static let confirmPassword = "confirm_password"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let email = "email"
        static let phoneNumber = "phone_number"
    }

    enum ParameterValue {
        
    }
}
