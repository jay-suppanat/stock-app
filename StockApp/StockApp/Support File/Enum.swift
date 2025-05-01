//
//  Enum.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

// MARK: - ServiceError

public enum ServiceError: Error {
    case noInternet
    case unauthorized
    case badRequest
    case unknown
}

// MARK: - SelectedTabBar

public enum SelectedTabBar: Int {
    case home = 0
    case search = 1
    case profile = 2
}

// MARK: - OpenController

public enum OpenController {
    case loginVC
}

// MARK: - CornerRadius

public enum CornerRadius {
    case roundHalf
    case roundDefault
    case card
}
