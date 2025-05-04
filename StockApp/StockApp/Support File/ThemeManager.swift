//
//  ThemeManager.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 3/5/2568 BE.
//

import UIKit

enum FontName: String {
    case bold = "JetBrainsMono-Bold"
    case regular = "JetBrainsMono-Regular"
    case semiBold = "JetBrainsMono-SemiBold"
}

class ThemeManager {
    static let shared = ThemeManager()

    var colors: ThemeColor {
        return ThemeColor()
    }

    var fonts: ThemeFont {
        return ThemeFont()
    }
}

// MARK: - ThemeColor

struct ThemeColor {
    public var black: UIColor { return UIColor.black }
    public var white: UIColor { return UIColor.white }
    public var tintColor: UIColor { return UIColor.tintColor }
    public var clear: UIColor { return UIColor.clear }
}

// MARK: - ThemeFont

struct ThemeFont {
    public func setBoldFont(size: CGFloat) -> UIFont {
        return UIFont(name: FontName.bold.rawValue, size: size)!
    }

    public func setRegularFont(size: CGFloat) -> UIFont {
        return UIFont(name: FontName.regular.rawValue, size: size)!
    }

    public func setSemiBoldFont(size: CGFloat) -> UIFont {
        return UIFont(name: FontName.semiBold.rawValue, size: size)!
    }
}
