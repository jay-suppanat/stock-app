//
//  UIViewController+Extension.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 2/5/2568 BE.
//

import UIKit

extension UIViewController {
    public static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
