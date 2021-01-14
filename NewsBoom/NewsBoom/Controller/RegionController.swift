//
//  RegionController.swift
//  NewsBoom
//
//  Created by Apple on 01/01/21.
//

import Foundation
import NotificationBannerSwift
import SwiftyJSON
extension RegionalViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listRegion.count == 0 {
            self.tblRegion.setEmptyMessage("No Data Found.")
        } else {
            self.tblRegion.restore()
        }
        return listRegion.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionTableViewCell") as! RegionTableViewCell
        cell.lbltitle.text = listRegion[indexPath.row].Title?.uppercased();
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let region = listRegion[indexPath.row];
        if(region.child?.count==0){
            let subCategoryVC = Constant.storyboard.instantiateViewController(withIdentifier: "SubCategoryNewsViewController") as! SubCategoryNewsViewController
            subCategoryVC.catID = region.Id!;
            subCategoryVC.headerTitle = region.Title!;
            self.navigationController?.pushViewController(subCategoryVC, animated: true)
        }
        else{
            if #available(iOS 13.0, *) {
                let vc = Constant.storyboard.instantiateViewController(identifier: "SubRegionViewController") as! SubRegionViewController
                vc.listRegion = listRegion[indexPath.row].child!
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                // Fallback on earlier versions
                let vc = Constant.storyboard.instantiateViewController(withIdentifier: "SubRegionViewController") as! SubRegionViewController
                vc.listRegion = listRegion[indexPath.row].child!
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    func GetReginalData(){
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestGETURL(Constant.getRegionalDataUrl, success: { [self]
            (JSON) in
            let msg =  JSON.dictionary?["Message"]
            if((JSON.dictionary?["IsSuccess"]) != false){
                let jsonData =  JSON.dictionary?["ResponseData"]!.rawString()!.data(using: .utf8)
                listRegion  =  try! JSONDecoder().decode([Region].self, from: jsonData!)
                tblRegion.reloadData()
                
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
