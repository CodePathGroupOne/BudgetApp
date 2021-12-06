//
//  AppDelegate.swift
//  WalletBud
//
//  Created by Ryan Johnson on 11/6/21.
//

import UIKit
import Parse
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "wGsjfFVuV72zh09EBtISlyR7Vqy3V44fek7Us6ls"
            $0.clientKey = "tA8TZQagClarZSYJ4ZeXIRUW7U2yRSwJdgcASiZ6"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: configuration)
       
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


}

