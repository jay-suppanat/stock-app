//
//  LoginResponse.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import Foundation

// MARK: - LoginResponse

struct LoginResponse: Codable {
    let tokenType, accessToken, username: String
    let userInfo: UserInfo

    init() {
        self.tokenType = ""
        self.accessToken = ""
        self.username = ""
        self.userInfo = .init()
    }

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
        case username
        case userInfo = "user_info"
    }
}

// MARK: - UserInfo

struct UserInfo: Codable {
    let firstName, lastName: String

    init() {
        self.firstName = ""
        self.lastName = ""
    }

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
