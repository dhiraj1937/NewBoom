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
        let signupVC = Constant.storyboard.instantiateViewController(identifier:"RegistrationViewController") as RegistrationViewController
        self.navigationController?.pushViewController(signupVC, animated: true);
    }
    
    @IBAction func btnSkip(sender:UIButton){
        let menuVC = Constant.storyboard.instantiateViewController(identifier:"MenuViewController") as MenuViewController
        let dashBoardVC = Constant.storyboard.instantiateViewController(identifier:"DashBoardViewController") as DashBoardViewController
        
        let frontNavigation = UINavigationController.init(rootViewController: dashBoardVC)
        let rearNavigation = UINavigationController.init(rootViewController: menuVC)

        let swvc:SWRevealViewController = SWRevealViewController.init(rearViewController: rearNavigation, frontViewController: frontNavigation)
        swvc.delegate = self;
        swvc.rearViewRevealWidth = self.view.frame.size.width-50
        self.navigationController?.pushViewController(swvc, animated: true);
    }
}
