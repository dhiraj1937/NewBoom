//
//  SubCategoryNewsController.swift
//  NewsBoom
//
//  Created by Apple on 20/12/20.
//

import Foundation
import NotificationBannerSwift
import SwiftyJSON
extension SubCategoryNewsViewController:UITableViewDelegate,UITableViewDataSource{
    
    //MARK: TableViewDelegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LatestNewsTableViewCell", for: indexPath) as! LatestNewsTableViewCell
        let homeNewsModel = listNews[indexPath.row];
        cell.SetData(homeNewsModel: homeNewsModel);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            let vc = Constant.storyboard.instantiateViewController(identifier: "NewsDetailViewController") as! NewsDetailViewController
            vc.newsHomeModel = listNews[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = Constant.storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
            vc.newsHomeModel = listNews[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    //MARK: Scrollview Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            if (offsetY > contentHeight - scrollView.frame.height * 4){
                if(!isLoading){
                    if(self.totalRecord != listNews.count){
                        GetNewsByCategoryData(categoryID: self.catID.description,pageNo: self.pageCount.description)
                    }
                }
            }
    }
    
    func GetNewsByCategoryData(categoryID:String,pageNo:String){
        isLoading = true;
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestGETURL(Constant.getNewsByCategoryIdUrl+"/"+categoryID+"/"+pageNo, success: { [self]
            (JSON) in
            let msg =  JSON.dictionary?["Message"]
            if((JSON.dictionary?["IsSuccess"]) != false){
                if(pageNo=="1")
                {
                    listNews.removeAll();
                }
                self.totalRecord =  JSON["TotalRecord"].int!
                self.pageCount =  JSON["Pages"].int!
                let jsonData =  JSON.dictionary?["ResponseData"]!.rawString()!.data(using: .utf8)
                let templistNews = try! JSONDecoder().decode([HomeNewsModel].self, from: jsonData!)
                if(templistNews.count>0){
                    self.listNews.append(contentsOf: templistNews);
                    tblNews.reloadData();
                }
            }
            else{
                self.ShowAlertMessage(message:msg!.description , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            self.removeSpinner(onView: self.view)
            self.tblNews.reloadData()
            isLoading = false;
            
        }, failure: { [self] (Error) in
            self.ShowAlertMessage(message: Error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
            self.tblNews.reloadData()
            isLoading = false;
        })
    }
}
