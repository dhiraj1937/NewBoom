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
    
    @IBAction func btnContinue(){
        if((UserDefaults.standard.string(forKey: "IsLoggedIn")) != nil){
            let menuVC = Constant.storyboard.instantiateViewController(identifier:"MenuViewController") as MenuViewController
            let dashBoardVC = Constant.storyboard.instantiateViewController(identifier:"DashBoardViewController") as DashBoardViewController
            
            let frontNavigation = UINavigationController.init(rootViewController: dashBoardVC)
            let rearNavigation = UINavigationController.init(rootViewController: menuVC)

            let swvc:SWRevealViewController = SWRevealViewController.init(rearViewController: rearNavigation, frontViewController: frontNavigation)
            swvc.delegate = self;
            swvc.rearViewRevealWidth = self.view.frame.size.width-50
            self.navigationController?.pushViewController(swvc, animated: true);
        }
        else{
            let signupVC = Constant.storyboard.instantiateViewController(identifier:"LoginViewController") as LoginViewController
            self.navigationController?.pushViewController(signupVC, animated: true);
        }
    }
    
    @IBAction func btnSelectLanguage(sender:UIButton){
        btnHindi.backgroundColor = UIColor.black
        btnEnglish.backgroundColor = UIColor.black
        sender.backgroundColor = Constant.appColor
        if(sender.tag==0){
            Constant.languageType = Language.Hindi
        }
        else{
            Constant.languageType = Language.English
        }
    }
}
