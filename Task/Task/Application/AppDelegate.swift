//
//  AppDelegate.swift
//  Task
//
//  Created by D, Prabhu (Cognizant) on 03/04/20.
//  Copyright © 2020 D, Prabhu (Cognizant). All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Variables
    var window: UIWindow?
    var navigationController: UINavigationController?
    lazy var getInstance: AppDelegate? = {

        if let appdelegate =  UIApplication.shared.delegate as? AppDelegate {
            return appdelegate
        }
        return nil

    }()

    // MARK: App's Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        buildUI()

        return true
    }

    // MARK: Instance Methods
    private func buildUI() {

        // Adjust Navigation UI
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBarAppearace.backgroundColor = UIColor.appColor
        navigationBarAppearace.barTintColor = UIColor.appColor
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.prefersLargeTitles = true

        // Build UI
        window = UIWindow(frame: UIScreen.main.bounds)
        navigationController = UINavigationController.init(rootViewController: FeedsListViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

    }

}


