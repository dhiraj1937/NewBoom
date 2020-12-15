//
//  AppDelegate.swift
//  NewsBoom
//
//  Created by Apple on 11/12/20.
//

import UIKit
import FBSDKCoreKit
import GoogleSignIn
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        GIDSignIn.sharedInstance().clientID = "491416938745-0j8j6suo6qmrrkri1tvjs54ighr3hmm1.apps.googleusercontent.com"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChooseLanguageViewController") as! ChooseLanguageViewController
        
        let nav = UINavigationController.init(rootViewController: controller)
        nav.setNavigationBarHidden(true, animated: true)
        window?.rootViewController = nav;
        window?.makeKeyAndVisible();
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    
   
}

