//
//  AppDelegate.swift
//  VK news feed
//
//  Created by Владимир on 22.03.2021.
//

import UIKit
import VKSdkFramework

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //var window: UIWindow?
    
    //var authService: AuthentificationService!
    
    static func shared() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        self.authService = AuthentificationService()
//        authService.delegate = self
        
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

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
    
    //MARK: AuthServiceDelegate
//    func authServiceShouldShow(_ viewController: UIViewController) {
//        print(#function)
////        window?.rootViewController?.present(viewController, animated: true, completion: nil)
//
//    }
//
//    func authServiceSignIn() {
//        print(#function)
//    }
//
//    func authServiceDidSignInFail() {
//        print(#function)
//    }

}

