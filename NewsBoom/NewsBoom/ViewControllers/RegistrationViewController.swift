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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblOTP.isHidden = true;
        txtOtp.isHidden = true;
    }
}
