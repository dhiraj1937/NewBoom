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
    @IBOutlet var viewBottom:UIView!
    @IBOutlet var sv:UIScrollView!
    
    
    var receivedOTP:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnResend.isHidden = true;
        self.txtOtp.isEnabled = false;
        self.txtOtp.alpha=0.5;
        self.btnResend.isEnabled = false;
        sv.contentSize = CGSize(width: 0, height: self.btnSubmit.frame.origin.y+self.btnSubmit.frame.size.height);
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegistrationViewController.keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(RegistrationViewController.keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
}
