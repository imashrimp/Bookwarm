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
        
        let config = Realm.Configuration(schemaVersion: 6) { migration, oldSchemaVersion in
            
            if oldSchemaVersion < 1 { } //Bool 타입 프로퍼티 스키마에서 삭제
            
            if oldSchemaVersion < 2 {
                
                migration.renameProperty(onType: BookTable.className(), from: "myMemo", to: "memo") //myMemo에서 memo로 프로퍼티 이름 변경
                
            }
            
            if oldSchemaVersion < 3 {
                
                migration.enumerateObjects(ofType: BookTable.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    new["memo"] = "감상평을 적어보세요."
                }
            } //메모에 일괄적으로 기본값 부여
            
            if oldSchemaVersion < 4 { } // stringSummary 프로퍼티 추가
            
            if oldSchemaVersion < 5 {
                
                migration.enumerateObjects(ofType: BookTable.className()) { oldObject, newObject in
                    guard let new = newObject, let old = oldObject else { return }
                    
                    new["stringSummary"] = "\(old["isbn"]) \(old["title"]) \(old["author"]) \(old["publisher"]) \(old["thumbnail"]) \(old["overview"]) \(old["memo"])"
                }
                
            }
            
            if oldSchemaVersion < 6 { }
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }
}

