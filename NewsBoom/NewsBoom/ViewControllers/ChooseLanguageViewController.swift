//
//  ChooseLanguageViewController.swift
//  NewsBoom
//
//  Created by Apple on 12/12/20.
//

import Foundation
class ChooseLanguageViewController: UIViewController,SWRevealViewControllerDelegate {

    @IBOutlet var btnHindi:UIButton!
    @IBOutlet var btnEnglish:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar(backgroundColor: Constant.appColor)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btnHindi.backgroundColor = UIColor.black
        btnEnglish.backgroundColor = UIColor.black
        if(Constant.languageType==Language.English){
            btnEnglish.backgroundColor = Constant.appColor
        }
        else{
            btnHindi.backgroundColor = Constant.appColor
        }
        Constant.ResetURL();
    }
    
    @IBAction func btnContinue(){
        if((UserDefaults.standard.string(forKey: "IsLoggedIn")) != nil || (UserDefaults.standard.string(forKey: "IsFirstTime")) != nil)
        {
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
            swvc.delegate = self;
            swvc.rearViewRevealWidth = self.view.frame.size.width-50
            self.navigationController?.pushViewController(swvc, animated: true);
           
        }
        else{
            if(Constant.languageType == Language.Hindi){
               
                UserDefaults.standard.setValue(1.description, forKey: "IsFirstTime")
            }
            else{
                
                UserDefaults.standard.setValue(0.description, forKey: "IsFirstTime")
            }
            
            UserDefaults.standard.synchronize()
            if #available(iOS 13.0, *) {
                let signupVC = Constant.storyboard.instantiateViewController(identifier:"LoginViewController") as LoginViewController
                self.navigationController?.pushViewController(signupVC, animated: true);
            } else {
                // Fallback on earlier versions
                let vc = Constant.storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(vc, animated: true);
            }
            
        }
    }
    
    @IBAction func btnSelectLanguage(sender:UIButton){
        btnHindi.backgroundColor = UIColor.black
        btnEnglish.backgroundColor = UIColor.black
        sender.backgroundColor = Constant.appColor
        if(sender.tag==0){
            Constant.languageType = Language.Hindi
            UserDefaults.standard.setValue(1.description, forKey: "IsFirstTime")
        }
        else{
            Constant.languageType = Language.English
            UserDefaults.standard.setValue(0.description, forKey: "IsFirstTime")
        }
       
        UserDefaults.standard.synchronize()
        Constant.ResetURL();
    }
}
