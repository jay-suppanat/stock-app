//
//  UILabel+Extension.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 2/5/2568 BE.
//

import UIKit

extension UILabel {
    public func setupLabel(text: String, textColor: UIColor, font: UIFont, cornerRadius: CornerRadius) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.setCornerRadius(cornerRadius: cornerRadius)
    }
}
