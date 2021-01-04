//
//  HomeController.swift
//  NewsBoom
//
//  Created by Apple on 16/12/20.
//

import Foundation
import NotificationBannerSwift
import SwiftyJSON

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listAllNews.count == 0 {
                self.tblNews.setEmptyMessage("No Data Found.")
            } else {
                self.tblNews.restore()
            }
        return listAllNews.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsModel = listAllNews[indexPath.row]
        if(newsModel.Newstype == "MD"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "MostDiscussedTableViewCell", for: indexPath) as! MostDiscussedTableViewCell
            cell.SetData(_listNewsModel: newsModel.listModeDisNews)
            return cell;
        }
        else if(newsModel.Newstype == "ADV"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdvertiseTableViewCell", for: indexPath) as! AdvertiseTableViewCell
            cell.SetData(advertiseModel: advertisement!)
            return cell;
        }
        if(newsModel.Newstype == "LN"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "LatestNewsTableViewCell", for: indexPath) as! LatestNewsTableViewCell
            cell.SetData(newsModel: newsModel)
            return cell;
        }
        if(newsModel.Newstype == "MR"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "MostReadTableViewCell", for: indexPath) as! MostReadTableViewCell
            cell.SetData(_listNewsModel: newsModel.listModeDisNews)
            return cell;
        }
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let newsModel = listAllNews[indexPath.row]
        if(newsModel.Newstype == "MD"){
            return 204;
        }
        else if(newsModel.Newstype == "ADV"){
            return 70;
        }
        else if(newsModel.Newstype == "LN"){
            return 100;
        }
        else if(newsModel.Newstype == "MR"){
            return 270;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsModel = listAllNews[indexPath.row]
        var vc:NewsDetailViewController?=nil;
        if #available(iOS 13.0, *) {
           vc = Constant.storyboard.instantiateViewController(identifier: "NewsDetailViewController") as! NewsDetailViewController
        } else {
            // Fallback on earlier versions
            vc = Constant.storyboard.instantiateViewController(withIdentifier:  "NewsDetailViewController") as! NewsDetailViewController
        }
        if(newsModel.Newstype == "MD"){
            
        }
        else if(newsModel.Newstype == "ADV"){
            if let url = URL(string: advertisement!.Link) {
                UIApplication.shared.open(url)
            }
        }
        else if(newsModel.Newstype == "LN"){
            vc!.newsHomeModel = newsModel.News?.homeNewsModel
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if(newsModel.Newstype == "MR"){
            
        }
       
    }
    
    
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
                    let newsModel = NewsModel(Id: MD.Id, NewsType: "MD", Title: MD.Title, Views: MD.NewsViews, Link: "", Img: MD.NewsImg?.first ?? "", DateTime: MD.ModDt,homeNewsModel:MD)
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
           // self.GetMostDiscussedNewData()
            self.GetLatestNewData()
        }, failure: { (Error) in
            self.ShowAlertMessage(message: Error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
            //self.GetMostDiscussedNewData()
            self.GetLatestNewData()
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
                    
                    let newsModel = NewsModel(Id: LN.Id, NewsType: "LN", Title: LN.Title, Views: LN.NewsViews, Link: "", Img: LN.NewsImg?.first ?? "", DateTime: LN.ModDt,homeNewsModel:LN)
                    let allNewsModelADV = AllNewsModel(Newstype:  "LN",listModeDisNews: [], Advertise: nil, News:  newsModel);
                    listAllNews.append(allNewsModelADV);
                }
                print(listAllNews)
            }
            else{
                self.ShowAlertMessage(message:msg!.description , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            self.removeSpinner(onView: self.view)
            self.tblNews.reloadData()
            
        }, failure: { [self] (Error) in
            self.ShowAlertMessage(message: Error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
            self.tblNews.reloadData()
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
                    let newsModel = NewsModel(Id: MR.Id, NewsType: "MR", Title: MR.Title, Views: MR.NewsViews, Link: "", Img: MR.NewsImg?.first ?? "", DateTime: MR.ModDt,homeNewsModel:MR)
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
            //GetLatestNewData()
            GetMostDiscussedNewData()
        }, failure: { [self] (Error) in
            self.ShowAlertMessage(message: Error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
            GetMostDiscussedNewData()
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
                Constant.globalAdvertisement = advertisement;
            }
            else{
                self.ShowAlertMessage(message:msg!.description , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            self.removeSpinner(onView: self.view)
            GetMostReadNewsData()
        }, failure: { [self] (Error) in
            self.ShowAlertMessage(message: Error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
            GetMostReadNewsData()
        })
    }
    
}
