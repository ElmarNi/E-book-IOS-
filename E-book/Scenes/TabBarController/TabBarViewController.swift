//
//  TabBarViewController.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 24.07.24.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00)
        UITabBar.appearance().backgroundColor = .white
        
        viewControllers = [
            createNavViewController(controller: HomeViewController(), title: "Рекомендации", imageName: "recommendation", tag: 0),
            createNavViewController(controller: MyBooksViewController(), title: "Мои книги", imageName: "books", tag: 1),
            createNavViewController(controller: SearchViewController(), title: "Поиск", imageName: "search", tag: 2),
            createNavViewController(controller: ProfileViewController(), title: "Профиль", imageName: "profile", tag: 3)
         ]
    }
    
    private func createNavViewController (controller: UIViewController, title: String, imageName: String, tag: Int) -> UIViewController {
        controller.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName)?.resize(targetSize: CGSizeMake(30, 30)), tag: tag)
        
        return CustomNavigationController(rootViewController: controller)
    }

}
