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
        
        ApiManager.sharedInstance.requestPOSTURL(Constant.customerRegistrationUrl, params:socialModel.dictionary , success: { (JSON) in
            self.removeSpinner(onView: self.view)
            let msg =  JSON["Message"].string
            if((JSON["IsSuccess"].bool) != false){
                self.navigationController?.popViewController(animated: true);
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
        
        ApiManager.sharedInstance.requestPOSTURL(Constant.SendOTPUrl, params:socialModel.dictionary , success: { (JSON) in
            self.removeSpinner(onView: self.view)
            let msg =  JSON["Message"].string
            if((JSON["IsSuccess"].bool) != false){
                self.txtOtp.isEnabled = true;
                self.btnResend.isEnabled = true;
            }
            else{
                self.ShowAlertMessage(message:msg! , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            
        }, failure:{ (Error) in
            self.ShowAlertMessage(message:Error.localizedDescription , vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
        })
        
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
        else if (txtOtp.text?.count==0) {
            ShowAlertMessage(message: "Please enter OTP", vc: self)
            return;
        }
        
        let registrationModle = RegisterModel(SignBy: "1", Firstname: txtName.text!, Lastname: txtName.text!, Email: txtEmail.text!, Password:txtPassword.text!)
        Registration(socialModel: registrationModle);
    }
}
