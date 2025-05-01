//
//  StockAppRouter.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import Alamofire

enum StockAppRouter: Router {
    case login(username: String, password: String)
    case register
    case delete
    case getUserInfo

    var method: HTTPMethod {
        switch self {
        case .getUserInfo:
            return .get
        default:
            return .post
        }
    }

    var baseURL: String {
        switch self {
        default:
            return "http://localhost:8080"
        }
    }

    var path: String {
        switch self {
        case .login:
            return "/login_stock_app"
        case .register:
            return "/register_user"
        case .delete:
            return "/delete_user"
        case .getUserInfo:
            return "/get_user_info"
        }
    }

    var parameters: Parameters? {
        switch self {
        case let .login(username, password):
            return [
                ServiceConstants.ParameterKey.username: username,
                ServiceConstants.ParameterKey.password: password
            ]
        default:
            return nil
        }
    }

    var header: [String : String] {
        switch self {
        default:
            return [
                ServiceConstants.HeaderKey.contentType: ServiceConstants.HeaderValue.json
            ]
        }
    }
}
