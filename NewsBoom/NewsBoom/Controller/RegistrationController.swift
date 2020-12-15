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
        do{
            
            ApiManager.sharedInstance.requestPOSTURL(Constant.customerRegistrationUrl, params:socialModel.dictionary , success: { (JSON) in
                self.removeSpinner(onView: self.view)
                let msg =  JSON["Message"].string
                if((JSON["IsSuccess"].bool) != false){
                    self.ShowAlertMessage(message:msg! , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
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
        catch let error{
            ShowAlertMessage(message: error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
        }
    }
    
    @IBAction func btnRegisterOTP(sender:UIButton){
        let socialModle = RegisterModel(SignBy: "1", Firstname: txtName.text!, Lastname: txtName.text!, Email: txtEmail.text!, Password:txtPassword.text!)
        
    }
}
