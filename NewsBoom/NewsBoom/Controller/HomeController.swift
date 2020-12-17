//
//  HomeController.swift
//  NewsBoom
//
//  Created by Apple on 16/12/20.
//

import Foundation
import NotificationBannerSwift
import SwiftyJSON
extension HomeViewController{
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return 5;
    //    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        return
    //    }
    
    
    func GetMostDiscussedNewData(){
        
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestGETURL(Constant.getmostdiscussNewsDataUrl, success: { [self]
            (JSON) in
            let msg =  JSON.dictionary?["Message"]
            if((JSON.dictionary?["IsSuccess"]) != false){
                let jsonData =  JSON.dictionary?["ResponseData"]!.rawString()!.data(using: .utf8)
                listMostDiscussNews = try! JSONDecoder().decode([HomeNewsModel].self, from: jsonData!)
                guard let listMd = listMostDiscussNews else {
                    return
                }
                var tempList = [NewsModel]()
                for MD in listMd {
                    let newsModel = NewsModel(Id: MD.Id, NewsType: "MD", Title: MD.Title, Views: MD.NewsViews, Link: "", Img: MD.NewsImg.first!, DateTime: MD.ModDt)
                    tempList.append(newsModel)
                }
                let allNewsModel = AllNewsModel(Newstype:  "MD",listModeDisNews: tempList, Advertise: nil, News:  nil);
                listAllNews.append(allNewsModel);
                
                let allNewsModelADV = AllNewsModel(Newstype:  "ADV",listModeDisNews: [], Advertise: advertisement, News:  nil);
                listAllNews.append(allNewsModelADV);
            }
            else{
                self.ShowAlertMessage(message:msg!.description , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            self.removeSpinner(onView: self.view)
            self.GetMostReadNewsData()
        }, failure: { (Error) in
            self.ShowAlertMessage(message: Error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
            self.GetMostReadNewsData()
        })
        
    }
    
    func GetLatestNewData(){
        
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestGETURL(Constant.getLatestNewsDataUrl, success: { [self]
            (JSON) in
            let msg =  JSON.dictionary?["Message"]
            if((JSON.dictionary?["IsSuccess"]) != false){
                let jsonData =  JSON.dictionary?["ResponseData"]!.rawString()!.data(using: .utf8)
                listLatestNews = try! JSONDecoder().decode([HomeNewsModel].self, from: jsonData!)
                print(listLatestNews!)
                guard let listLN = listLatestNews else {
                    return
                }
                for LN in listLN {
                    let newsModel = NewsModel(Id: LN.Id, NewsType: "LN", Title: LN.Title, Views: LN.NewsViews, Link: "", Img: LN.NewsImg.first!, DateTime: LN.ModDt)
                    let allNewsModelADV = AllNewsModel(Newstype:  "LN",listModeDisNews: [], Advertise: nil, News:  newsModel);
                    listAllNews.append(allNewsModelADV);
                }
                print(listAllNews)
            }
            else{
                self.ShowAlertMessage(message:msg!.description , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            self.removeSpinner(onView: self.view)
            self.GetMostReadNewsData();
        }, failure: { [self] (Error) in
            self.ShowAlertMessage(message: Error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
            self.GetMostReadNewsData();
        })
        
    }
    
    func GetMostReadNewsData(){
        
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestGETURL(Constant.getmostreadNewsDataUrl, success: { [self]
            (JSON) in
            let msg =  JSON.dictionary?["Message"]
            if((JSON.dictionary?["IsSuccess"]) != false){
                let jsonData =  JSON.dictionary?["ResponseData"]!.rawString()!.data(using: .utf8)
                listMostReadNews = try! JSONDecoder().decode([HomeNewsModel].self, from: jsonData!)
                guard let listMR = listMostReadNews else {
                    return
                }
                var tempList = [NewsModel]()
                for MR in listMR {
                    let newsModel = NewsModel(Id: MR.Id, NewsType: "MR", Title: MR.Title, Views: MR.NewsViews, Link: "", Img: MR.NewsImg.first!, DateTime: MR.ModDt)
                    tempList.append(newsModel)
                }
                let allNewsModel = AllNewsModel(Newstype:  "MR",listModeDisNews: tempList, Advertise: nil, News: nil);
                listAllNews.append(allNewsModel);
                
                let allNewsModelADV = AllNewsModel(Newstype:  "ADV",listModeDisNews: [], Advertise: advertisement, News:  nil);
                listAllNews.append(allNewsModelADV);
            }
            else{
                self.ShowAlertMessage(message:msg!.description , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            self.removeSpinner(onView: self.view)
            GetLatestNewData()
        }, failure: { [self] (Error) in
            self.ShowAlertMessage(message: Error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
            GetLatestNewData()
        })
        
    }
    
    func GetAdvData(){
        
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestGETURL(Constant.getAdvUrl, success: { [self]
            (JSON) in
            let msg =  JSON.dictionary?["Message"]
            if((JSON.dictionary?["IsSuccess"]) != false){
                let jsonData =  JSON.dictionary?["ResponseData"]!.rawString()!.data(using: .utf8)
                advertisement = try! JSONDecoder().decode(AdvertiseModel.self, from: jsonData!)
              
            }
            else{
                self.ShowAlertMessage(message:msg!.description , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            self.removeSpinner(onView: self.view)
            GetMostDiscussedNewData()
        }, failure: { [self] (Error) in
            self.ShowAlertMessage(message: Error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
            GetMostDiscussedNewData()
        })
        
    }
    
    
}
