//
//  Router.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import Alamofire
import Foundation

// MARK: URLRequestConvertible

protocol Router: URLRequestConvertible {
    var method: HTTPMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var header: [String: String] { get }
}

// MARK: APIRouter

extension Router {
    func asURLRequest() throws -> URLRequest {
        let url = try self.composeURL()
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        request.allHTTPHeaderFields = self.header

        if let parameters = self.parameters, self.method == .post {
            if self.header[ServiceConstants.HeaderKey.contentType] == ServiceConstants.HeaderValue.json {
                request.httpBody = StockAppUtil().convertToJSONData(from: parameters)
            } else {
                request.httpBody = StockAppUtil().createQueryString(from: parameters)
            }
        }

        return request
    }

    private func composeURL() throws -> URL {
        let base = try self.baseURL.asURL()
        let url = base.appendingPathComponent(self.path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!

        if self.method == .get, let parameters = self.parameters {
            components.queryItems = parameters.compactMap({ key, value in
                return URLQueryItem(name: key, value: "\(value)")
            })
        }

        guard let composedURL = components.url else {
            throw URLError(.badURL)
        }

        return composedURL
    }
}
