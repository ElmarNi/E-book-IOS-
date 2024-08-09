//
//  AppDelegate.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 19.04.24.
//

import GoogleSignIn
import Firebase
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        setupRootViewController()
        setupAppearance()
        configureFirebase()
        
        return true
    }
    
    private func setupRootViewController() {
        let isOpened = UserDefaults.standard.bool(forKey: "isOpened")
        let clientID = UserDefaults.standard.value(forKey: "clientID") as? Int
        
        if !isOpened {
            window?.rootViewController = CustomNavigationController(rootViewController: WelcomeViewController())
            UserDefaults.standard.setValue(true, forKey: "isOpened")
        } else if clientID != nil {
            window?.rootViewController = TabBarViewController()
        } else {
            window?.rootViewController = CustomNavigationController(rootViewController: LoginViewController())
        }
        
        window?.makeKeyAndVisible()
    }
    
    private func setupAppearance() {
        UINavigationBar.appearance().tintColor = .label
    }
    
    private func configureFirebase() {
        FirebaseApp.configure()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
