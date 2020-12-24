//
//  RegistrationController.swift
//  NewsBoom
//
//  Created by Apple on 16/12/20.
//

import Foundation
import NotificationBannerSwift
import SwiftyJSON
extension RegistrationViewController{
    
    func Registration(socialModel:RegisterModel){
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestPOSTURL(Constant.customerRegistrationUrl, params:socialModel.dictionary , success: { (JSON) in
            self.removeSpinner(onView: self.view)
            let msg =  JSON["Message"].string
            if((JSON["IsSuccess"].bool) != false){
                self.navigationController?.popViewController(animated: true);
                self.ShowAlertMessage(message:msg! , vc: self,title:"Success",bannerStyle: BannerStyle.success)
            }
            else{
                self.ShowAlertMessage(message:msg! , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            
        }, failure:{ (Error) in
            self.ShowAlertMessage(message:Error.localizedDescription , vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
        })
        
    }
    
    func SendOTP(socialModel:RegisterModel){
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestPOSTURL(Constant.SendOTPUrl, params:socialModel.dictionary , success: { (JSON) in
            self.removeSpinner(onView: self.view)
            let msg =  JSON["Message"].string
            if((JSON["IsSuccess"].bool) != false){
                
                self.txtOtp.isEnabled = true;
                self.btnResend.isEnabled = true;
                self.receivedOTP = JSON["Otp"].string;
                self.btnSubmit.tag=2;
                self.btnSubmit.setTitle("Submit", for: UIControl.State.normal)
                self.ShowAlertMessage(message:msg! , vc: self,title:"Success",bannerStyle: BannerStyle.success)
            }
            else{
                self.ShowAlertMessage(message:msg! , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            
        }, failure:{ (Error) in
            self.ShowAlertMessage(message:Error.localizedDescription , vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
        })
        
    }
    
    @IBAction func btnResendOTP(){
        let registrationModle = RegisterModel(SignBy: "1", Firstname: txtName.text!, Lastname: txtName.text!, Email: txtEmail.text!, Password:txtPassword.text!)
        SendOTP(socialModel:registrationModle);
    }
    
    @IBAction func btnRegisterOTP(sender:UIButton){
        
        if (txtName.text?.count==0) {
            ShowAlertMessage(message: "Please enter name", vc: self)
            return;
        }
        else if (txtEmail.text?.count==0) {
            ShowAlertMessage(message: "Please enter email", vc: self)
            return;
        }
        else if (txtPassword.text?.count==0) {
            ShowAlertMessage(message: "Please enter password", vc: self)
            return;
        }
        let registrationModle = RegisterModel(SignBy: "1", Firstname: txtName.text!, Lastname: txtName.text!, Email: txtEmail.text!, Password:txtPassword.text!)
        
        if(btnSubmit.tag==2){
            if (txtOtp.text?.count==0) {
                ShowAlertMessage(message: "Please enter OTP", vc: self)
                return;
            }
            else if (txtOtp.text == receivedOTP) {
                ShowAlertMessage(message: "Please enter correct OTP.", vc: self)
                return;
            }
            Registration(socialModel: registrationModle);
        }
        else{
            SendOTP(socialModel: registrationModle)
        }
    }
}
