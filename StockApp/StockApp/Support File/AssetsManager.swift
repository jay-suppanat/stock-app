//
//  AssetsManager.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import UIKit

enum AssetsManager: String {
    case profile_icon
    case search_icon
    case home_icon

    var image: UIImage {
        return UIImage(named: rawValue)!
    }
}
