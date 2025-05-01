//
//  Client.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import Foundation
import Alamofire
import PromiseKit

class Client {
    static let shared = Client()

    static func request<T: Codable, R: URLRequestConvertible>(route: R) -> Promise<T> {
        return Promise<T> { seal in
            AF.request(route).responseDecodable { (response: DataResponse<T, AFError>) in
                switch response.result {
                case .success(let value):
                    seal.fulfill(value)
                case .failure:
                    guard let statusCode = response.response?.statusCode else {
                        return seal.reject(ServiceError.unknown)
                    }
                    let error = self.errorHandler(statusCode: statusCode)
                    seal.reject(error)
                }
            }
        }
    }

    private static func errorHandler(statusCode: Int) -> Error {
        switch statusCode {
        case 401:
            return ServiceError.unauthorized
        case 400, 404:
            return ServiceError.badRequest
        default:
            return ServiceError.unknown
        }
    }
}
