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
        
        if((UserDefaults.standard.string(forKey: "IsFirstTime")) == nil){
            let controller = storyboard.instantiateViewController(withIdentifier: "ChooseLanguageViewController") as! ChooseLanguageViewController
            let nav = UINavigationController.init(rootViewController: controller)
            nav.setNavigationBarHidden(true, animated: true)
            window?.rootViewController = nav;
            
        }
        else{
            let lng =  UserDefaults.standard.string(forKey: "IsFirstTime");
            if(lng=="0"){
                Constant.languageType = Language.English;
            }
            else{
                Constant.languageType = Language.Hindi;
            }
            
            
            var menuVC:MenuViewController? = nil;
            var dashBoardVC:DashBoardViewController? = nil;
            if #available(iOS 13.0, *) {
                 dashBoardVC = Constant.storyboard.instantiateViewController(identifier:"DashBoardViewController") as DashBoardViewController
                menuVC = Constant.storyboard.instantiateViewController(identifier:"MenuViewController") as MenuViewController
            } else {
                // Fallback on earlier versions
                dashBoardVC = Constant.storyboard.instantiateViewController(withIdentifier: "DashBoardViewController") as? DashBoardViewController
                menuVC = Constant.storyboard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
            }
            let frontNavigation = UINavigationController.init(rootViewController: dashBoardVC!)
            let rearNavigation = UINavigationController.init(rootViewController: menuVC!)

            let swvc:SWRevealViewController = SWRevealViewController.init(rearViewController: rearNavigation, frontViewController: frontNavigation)
            //swvc.rearViewRevealWidth = 50;//window..frame.size.width-50
            
            let nav = UINavigationController.init(rootViewController: swvc)
            nav.setNavigationBarHidden(true, animated: true)
            window?.rootViewController = nav;
        }
        
       
        window?.makeKeyAndVisible();
        UINavigationBar.appearance().backgroundColor = UIColor.init(hexString: "#C00A00")
        UINavigationBar.appearance().tintColor = UIColor.black;
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
}

