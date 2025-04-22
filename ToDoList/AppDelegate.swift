//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Furkan Gönel on 19.04.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        copyDatabaseIfNeeded()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    
    func copyDatabaseIfNeeded() {
        let bundlePath = Bundle.main.path(forResource: "todo_app", ofType: "sqlite")!
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let fullTargetPath = (targetPath as NSString).appendingPathComponent("todo_app.sqlite")

        if !fileManager.fileExists(atPath: fullTargetPath) {
            do {
                try fileManager.copyItem(atPath: bundlePath, toPath: fullTargetPath)
                print("Veritabanı kopyalandı ✅")
            } catch {
                print("Kopyalama hatası: \(error.localizedDescription)")
            }
        } else {
            print("Database already exists")
        }
    }

}

