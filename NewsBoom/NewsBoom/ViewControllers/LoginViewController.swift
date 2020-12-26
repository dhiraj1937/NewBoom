//
//  LoginViewController.swift
//  NewsBoom
//
//  Created by Apple on 12/12/20.
//

import Foundation
import UIKit
class LoginViewController: UIViewController,SWRevealViewControllerDelegate{
    
    @IBOutlet var txtEmail:UITextField!
    @IBOutlet var txtPassword:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSignUp(sender:UIButton){
        if #available(iOS 13.0, *) {
            let signupVC = Constant.storyboard.instantiateViewController(identifier:"RegistrationViewController") as RegistrationViewController
            self.navigationController?.pushViewController(signupVC, animated: true);
        } else {
            // Fallback on earlier versions
            let signupVC = Constant.storyboard.instantiateViewController(withIdentifier:"RegistrationViewController") as! RegistrationViewController
            self.navigationController?.pushViewController(signupVC, animated: true);
        }
       
    }
    
    @IBAction func btnSkip(sender:UIButton){
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false);
    }
}
