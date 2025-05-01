//
//  StockAppClient.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import Alamofire

enum StockAppClient {
    static func requestLogin(username: String,
                             password: String,
                             completion: @escaping (LoginResponse) -> Void) {
        Client.request(route: StockAppRouter.login(username: username,
                                                   password: password))
        .done { (response: LoginResponse) in completion(response) }
        .catch { _ in }
        .finally {}
    }
}
