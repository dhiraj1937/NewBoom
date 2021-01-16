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
        let userInfo: NSDictionary = sender.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        sv.contentInset = contentInsets
        sv.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        sv.contentInset = .zero
            sv.scrollIndicatorInsets = .zero
    }
   
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
}
