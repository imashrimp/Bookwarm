//
//  AppDelegate.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/07/31.
//

import UIKit
import IQKeyboardManagerSwift
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let config = Realm.Configuration(schemaVersion: 1) { migration, oldSchemaVersion in
            
            if oldSchemaVersion < 1 { }
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }
}

