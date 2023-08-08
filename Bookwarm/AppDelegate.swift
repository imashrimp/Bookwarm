//
//  AppDelegate.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/07/31.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().backgroundColor = .white
        IQKeyboardManager.shared.enable = true
        return true
    }
}

