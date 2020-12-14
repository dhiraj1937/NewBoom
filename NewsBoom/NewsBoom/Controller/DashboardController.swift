//
//  DashboardController.swift
//  NewsBoom
//
//  Created by Apple on 13/12/20.
//

import Foundation
import NotificationBannerSwift
extension DashBoardViewController{
    
    func GetAllParentCategoryData(){
        do{
            try
                self.showSpinner(onView: self.view)
            ApiManager.sharedInstance.requestGETURL(Constant.getAllParentCategoryDataUrl, success: { [self]
                (JSON) in
                let msg =  JSON.dictionary?["Message"]
                if((JSON.dictionary?["IsSuccess"]) != false){
                    let jsonData =  JSON.dictionary?["ResponseData"]!.rawString()!.data(using: .utf8)
                    self.blogPosts = try! JSONDecoder().decode([ParentCategory].self, from: jsonData!)
                    if self.blogPosts != nil {
                        self.SetUptabs()
                    }
                }
                else{
                    self.ShowAlertMessage(message:msg!.description , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
                }
                self.removeSpinner(onView: self.view)
            }, failure: { (Error) in
                self.ShowAlertMessage(message: Error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
                self.removeSpinner(onView: self.view)
            })
        }
        catch let error{
            ShowAlertMessage(message: error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
        }
    }
}
