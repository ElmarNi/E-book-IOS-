//
//  AppDelegate.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 19.04.24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}

