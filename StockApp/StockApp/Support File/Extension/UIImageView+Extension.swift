//
//  UIImageView+Extension.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 2/5/2568 BE.
//

import UIKit

extension UIImageView {
    public func setupImageView(image: AssetsManager, tintColor: UIColor) {
        self.backgroundColor = UIColor.clear
        self.image = image.image.withTintColor(tintColor, renderingMode: .alwaysOriginal)
    }
}
