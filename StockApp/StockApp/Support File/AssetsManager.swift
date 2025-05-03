//
//  AssetsManager.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import UIKit

public enum AssetsManager: String {
    case profile_icon
    case search_icon
    case home_icon
    case close_icon

    var image: UIImage {
        return UIImage(named: rawValue)!
    }
}
