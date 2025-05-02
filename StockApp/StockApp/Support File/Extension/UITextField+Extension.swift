//
//  UITextField+Extension.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import UIKit

extension UITextField {
    public func setupTextField(placeholder: String = "",
                               textColor: UIColor,
                               borderStyle: BorderStyle = .none,
                               cornerRadius: CornerRadius,
                               contentType: UITextContentType = .username) {
        self.textColor = textColor
        self.placeholder = placeholder
        self.borderStyle = borderStyle
        self.textContentType = contentType
    }
}
