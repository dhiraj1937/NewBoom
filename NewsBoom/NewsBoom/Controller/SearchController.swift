//
//  SearchController.swift
//  NewsBoom
//
//  Created by Apple on 21/12/20.
//

import Foundation
import NotificationBannerSwift
import SwiftyJSON
extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNews.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LatestNewsTableViewCell", for: indexPath) as! LatestNewsTableViewCell
        let homeNewsModel = listNews[indexPath.row];
        cell.SetData(homeNewsModel: homeNewsModel);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Constant.storyboard.instantiateViewController(identifier: "NewsDetailViewController") as! NewsDetailViewController
        vc.newsHomeModel = listNews[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func GetNewsBykeyData(serchKey:String){
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestPOSTURL(Constant.getNewsSearchUrl, params:["search":searchKey!.description as String,"page":1] , success: { [self] (JSON) in
            self.removeSpinner(onView: self.view)
            let msg =  JSON["Message"].string
            if((JSON["IsSuccess"].bool) != false){
                let jsonData =  JSON.dictionary?["ResponseData"]!.rawString()!.data(using: .utf8)
                let templistNews = try! JSONDecoder().decode([HomeNewsModel].self, from: jsonData!)
                if(templistNews.count>0){
                    self.listNews.append(contentsOf: templistNews);
                    tblNews.reloadData();
                }
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
