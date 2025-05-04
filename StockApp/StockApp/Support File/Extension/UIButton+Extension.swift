//
//  UIButton+Extension.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import UIKit

extension UIButton {
    public func setupButtonTheme(text: String = "",
                                 textColor: UIColor = UIColor.black,
                                 font: UIFont = UIFont.systemFont(ofSize: 14),
                                 backgroundColor: UIColor = UIColor.white,
                                 cornerRadius: CornerRadius = .card) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
        self.setCornerRadius(cornerRadius: cornerRadius)
    }
}
