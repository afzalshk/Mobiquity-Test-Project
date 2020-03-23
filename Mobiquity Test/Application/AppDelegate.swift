//
//  AppDelegate.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 21/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setRoot()
        return true
    }

    
    func setRoot() {
        let homeViewController = MainViewController.initFromStoryboard()
        homeViewController.viewModel = MainViewModelImp()
        let nav = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

