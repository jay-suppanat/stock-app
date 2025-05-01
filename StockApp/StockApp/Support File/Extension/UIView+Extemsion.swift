//
//  UIView+Extemsion.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import UIKit

extension UIView {
    public func setCornerRadius(cornerRadius: CornerRadius) {
        switch cornerRadius {
        case .roundHalf:
            self.layer.cornerRadius = self.frame.height / 2
        case .roundDefault:
            self.layer.cornerRadius = 10
        case .card:
            self.layer.cornerRadius = 5
        }

        self.layer.masksToBounds = true
    }
}
