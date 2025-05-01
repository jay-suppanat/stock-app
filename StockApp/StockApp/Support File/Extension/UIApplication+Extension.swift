//
//  UIApplication+Extension.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 1/5/2568 BE.
//

import UIKit

extension UIApplication {
    public func getTopViewController(base: UIViewController? = UIApplication.shared.connectedScenes
        .compactMap { ($0 as? UIWindowScene)?.keyWindow }
        .first?.rootViewController) -> UIViewController? {
            if let nav = base as? UINavigationController {
                return self.getTopViewController(base: nav.visibleViewController)
            }

            if let tab = base as? UITabBarController {
                return self.getTopViewController(base: tab.selectedViewController)
            }

            if let presented = base?.presentedViewController {
                return self.getTopViewController(base: presented.presentedViewController)
            }

            return base
    }

    public func getTabBarViewController() -> UITabBarController? {
        let base: UITabBarController? = UIApplication.shared.connectedScenes.compactMap {
            ($0 as? UIWindowScene)?.keyWindow
        }.first?.rootViewController as? UITabBarController

        return base
    }
}
