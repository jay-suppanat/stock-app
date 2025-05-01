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
