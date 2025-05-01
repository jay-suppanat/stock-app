//
//  ViewController.swift
//  StockApp
//
//  Created by Suppanat Chinthumrucks on 29/4/2568 BE.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    let tabBarImages: [UIImage] = [
        AssetsManager.home_icon.image,
        AssetsManager.search_icon.image,
        AssetsManager.profile_icon.image
    ]
}

// MARK: LifeCycle

extension MainTabBarViewController: LifeCycle {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyTabBarAppearanceThemes()
        self.initTabBar()
    }
}

// MARK: Themes

extension MainTabBarViewController: Themes {
    private func applyTabBarAppearanceThemes() {
        let normalAttribute: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray
        ]

        let selectedAttribute: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]

        let appearance = UITabBarAppearance()

        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttribute
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttribute
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
        self.tabBar.standardAppearance = appearance
    }
}

// MARK: UserInterface

extension MainTabBarViewController: UserInterface {
    private func initTabBar() {
        guard let items = self.tabBar.items, items.count == self.tabBarImages.count else {
            return
        }

        for (index, item) in items.enumerated() {
            item.title = ""
            item.image = self.tabBarImages[index].withTintColor(UIColor.gray)
            item.selectedImage = self.tabBarImages[index].withTintColor(UIColor.white)
        }
    }
}

