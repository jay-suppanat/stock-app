//
//  UIImage+Extension.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import UIKit

extension UIImage {
    public func setTintColor(color: UIColor) {
        self.withTintColor(color, renderingMode: .alwaysOriginal)
    }
}
