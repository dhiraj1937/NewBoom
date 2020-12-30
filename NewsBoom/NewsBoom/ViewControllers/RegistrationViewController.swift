//
//  RegistrationViewController.swift
//  NewsBoom
//
//  Created by Apple on 14/12/20.
//

import Foundation
class RegistrationViewController: UIViewController{
    @IBOutlet var txtEmail:UITextField!
    @IBOutlet var txtPassword:UITextField!
    @IBOutlet var txtName:UITextField!
    @IBOutlet var txtOtp:UITextField!
    @IBOutlet var lblOTP:UILabel!
    @IBOutlet var btnResend:UIButton!
    @IBOutlet var btnSubmit:UIButton!
    
    var receivedOTP:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnResend.isHidden = true;
        self.txtOtp.isEnabled = false;
        self.txtOtp.alpha=0.5;
        self.btnResend.isEnabled = false;
    }
}
