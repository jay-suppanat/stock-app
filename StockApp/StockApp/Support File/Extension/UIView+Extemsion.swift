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
        case .none:
            self.layer.cornerRadius = 0
        }

        self.layer.masksToBounds = true
    }

    public func showHideWithAnimation(isShow: Bool) {
        if isShow {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.alpha = 0
            }
        }
    }

    public func setupLineView() {
        self.backgroundColor = UIColor.gray
        self.setCornerRadius(cornerRadius: .roundHalf)
    }
}
