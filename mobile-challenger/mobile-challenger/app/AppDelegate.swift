//
//  AppDelegate.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 18/02/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setNavigationBar()
        self.configureInitialViewController()

        return true
    }

    private func setNavigationBar() {
        UINavigationBar.appearance().barTintColor = .darkGrayColor()
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for:UIBarMetrics.default)
    }
    
    private func configureInitialViewController() {
        window = UIWindow()

        let storyboard = UIStoryboard(name: "home", bundle: nil)

        let startViewController = storyboard.instantiateViewController(withIdentifier: "mainHome")
        
        window?.rootViewController = startViewController
        window?.makeKeyAndVisible()
    }
}

