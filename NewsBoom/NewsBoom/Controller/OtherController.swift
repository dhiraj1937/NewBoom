//
//  OtherController.swift
//  NewsBoom
//
//  Created by Apple on 21/12/20.
//

import Foundation
import NotificationBannerSwift
import SwiftyJSON
extension OtherInfoViewController{
    
 func GetOtherInfoData(slug:String){
        
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestGETURL(Constant.getPageUrl+"/"+slug, success: { [self]
            (JSON) in
            let msg =  JSON.dictionary?["Message"]
            if((JSON.dictionary?["IsSuccess"]) != false){
                let jsonData =  JSON.dictionary?["ResponseData"]!.rawString()!.data(using: .utf8)
                let pageData:OtherInfoModel? = try! JSONDecoder().decode(OtherInfoModel.self, from: jsonData!)
                
                guard let otherData = pageData else {
                    return;
                }
                self.txtView.attributedText = otherData.Content.htmlToAttributedString;
            }
            else{
                self.ShowAlertMessage(message:msg!.description , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            self.removeSpinner(onView: self.view)
            
        }, failure: { [self] (Error) in
            self.ShowAlertMessage(message: Error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
            
        })
    }
}
