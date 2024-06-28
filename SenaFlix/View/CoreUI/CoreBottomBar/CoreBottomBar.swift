//
//  CoreBottomBar.swift
//  SenaFlix
//
//  Created by Lucas Sena on 23/06/24.
//

import Foundation
import UIKit

class CoreBottomBar: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewControllers = [splash, homeTabBar, favoritesTabBar]
        applyStyle()
    }
    
    lazy public var splash: UINavigationController = {
        let splash = SplashViewController()
        return UINavigationController(rootViewController: splash)
    }()
    
    lazy public var homeTabBar: UINavigationController = {
        let home = HomeViewController()
        let title = "Home"
        let defaultImage = UIImage(systemName: "house")
        let selectedImage = UIImage(systemName: "house.fill")
        let tabBarItems = (title: title, image: defaultImage, selectedImage: selectedImage)
        let tabBarItem = UITabBarItem(title: tabBarItems.title, image: tabBarItems.image, selectedImage: tabBarItems.selectedImage)
        home.tabBarItem = tabBarItem
        return UINavigationController(rootViewController: home)
    }()
    
    lazy public var favoritesTabBar: UINavigationController = {
        let favoritesTabBar = FavoritesViewController()
        let title = "Favorites"
        let defaultImage = UIImage(systemName: "star")
        let selectedImage = UIImage(systemName: "star.fill")
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        favoritesTabBar.tabBarItem = tabBarItem
        return UINavigationController(rootViewController: favoritesTabBar)
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func applyStyle() {
        let standardAppearance = UITabBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor(named: K.appColors.black600)
        self.tabBar.standardAppearance = standardAppearance
        self.tabBar.scrollEdgeAppearance = standardAppearance
    }
}

extension CoreBottomBar: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
