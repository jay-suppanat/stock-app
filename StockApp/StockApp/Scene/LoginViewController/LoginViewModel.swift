//
//  LoginViewModel.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import Combine

class LoginViewModel {
    init() {
        self.loginResponseEvent = .init(.init())
        self.cancellables = []
    }

    public let loginResponseEvent: CurrentValueSubject<LoginResponse, Never>
    public var cancellables: Set<AnyCancellable>
}

// MARK: - Service

extension LoginViewModel: Service {
    public func requestLoginService(username: String, password: String) {
        StockAppClient.requestLogin(username: username,
                                    password: password) { response in
            self.loginResponseEvent.send(response)
        }
    }
}
