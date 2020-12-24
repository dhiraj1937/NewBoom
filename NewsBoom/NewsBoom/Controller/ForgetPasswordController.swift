//
//  ForgetPasswordController.swift
//  NewsBoom
//
//  Created by Apple on 25/12/20.
//

import Foundation
import NotificationBannerSwift
import SwiftyJSON
extension ForgetPasswordPopupViewController{
    @IBAction func btnSubmitCLick(){
        if (txtEmail.text?.count==0) {
            ShowAlertMessage(message: "Please enter email", vc: self)
            return;
        }
        ForgetPassword()
    }
    
    func ForgetPassword(){
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestGETURL(Constant.forgotPasswordUrl+"/"+txtEmail.text! , success: { [self] (JSON) in
            self.removeSpinner(onView: self.view)
            let msg =  JSON["Message"].string
            if((JSON["IsSuccess"].bool) != false){
                
                self.ShowAlertMessage(message:msg! , vc: self,title:"Success",bannerStyle: BannerStyle.success)
                txtEmail.text = "";
            }
            else{
                self.ShowAlertMessage(message:msg! , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            
        }, failure:{ (Error) in
            self.ShowAlertMessage(message:Error.localizedDescription , vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
        })
        
    }
}
