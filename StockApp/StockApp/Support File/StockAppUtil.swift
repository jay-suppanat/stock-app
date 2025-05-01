//
//  StockAppUtil.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import Foundation

class StockAppUtil {
    public func createQueryString(from parameters: [String: Any]?) -> Data? {
        guard let parameters = parameters else {
            return nil
        }

        let queryString = parameters.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")

        return queryString.data(using: .utf8)
    }

    public func convertToJSONData(from param: [String: Any]?) -> Data? {
        if let param = param {
            do {
                return try JSONSerialization.data(withJSONObject: param, options: [])
            } catch {
                print("Error: cannot create JSON from dictionary.")
                return nil
            }
        }
        return nil
    }
}
